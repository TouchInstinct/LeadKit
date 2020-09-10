//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Alamofire
import RxSwift
import RxAlamofire

typealias ServerResponse = (HTTPURLResponse, Data)

public extension Reactive where Base: DataRequest {

    /// Method that serializes response into target object
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Parameter decoder: JSONDecoder used to decode a decodable type
    /// - Returns: Observable with HTTP URL Response and target object
    func apiResponse<T: Decodable>(mappingQueue: DispatchQueue = .global(), decoder: JSONDecoder)
        -> Observable<SessionManager.ModelResponse<T>> {

            return response(onQueue: mappingQueue)
                .tryMapResult { response, data in
                    (response, try decoder.decode(T.self, from: data))
                }
                .catchAsRequestError(with: self.base)
    }

    /// Method that serializes response into target object
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func observableApiResponse<T: ObservableMappable>(mappingQueue: DispatchQueue = .global(), decoder: JSONDecoder)
        -> Observable<SessionManager.ModelResponse<T>> {

            return response(onQueue: mappingQueue)
                .tryMapObservableResult { response, value in
                    let json = try JSONSerialization.jsonObject(with: value, options: [])
                    return T.create(from: json, with: decoder)
                        .map { (response, $0) }
                }
                .catchAsRequestError(with: self.base)
    }

    /// Method that serializes response into data
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and data
    func dataApiResponse(mappingQueue: DispatchQueue) -> Observable<SessionManager.DataResponse> {
        return response(onQueue: mappingQueue)
            .map { $0 as SessionManager.DataResponse }
            .catchAsRequestError(with: self.base)
    }

    private func response(onQueue queue: DispatchQueue) -> Observable<(HTTPURLResponse, Data)> {
        return responseResult(queue: queue, responseSerializer: DataResponseSerializer())
    }
}

public extension ObservableType where Element == DataRequest {

    /// Method that validates status codes and catch network errors
    ///
    /// - Parameter statusCodes: set of status codes to validate
    /// - Returns: Observable on self
    func validate(statusCodes: Set<Int>) -> Observable<Element> {
        return map { $0.validate(statusCode: statusCodes) }
            .catchAsRequestError()
    }
}

private extension ObservableType where Element == ServerResponse {

    func tryMapResult<R>(_ transform: @escaping (Element) throws -> R) -> Observable<R> {
        return map {
            do {
                return try transform($0)
            } catch {
                throw RequestError.mapping(error: error, response: $0.1)
            }
        }
    }

    func tryMapObservableResult<R>(_ transform: @escaping (Element) throws -> Observable<R>) -> Observable<R> {
        return flatMap { response, result -> Observable<R> in
            do {
                return try transform((response, result))
                    .catchError {
                        throw RequestError.mapping(error: $0, response: result)
                    }
            } catch {
                throw RequestError.mapping(error: error, response: result)
            }
        }
    }
}

private extension ObservableType {

    func catchAsRequestError(with request: DataRequest? = nil) -> Observable<Element> {
        return catchError { error in
            let resultError: RequestError
            let response = request?.data

            switch error {
            case let requestError as RequestError:
                resultError = requestError

            case let afError as AFError:
                switch afError {
                case let .sessionTaskFailed(error):
                    switch error {
                    case let urlError as URLError where urlError.code == .notConnectedToInternet:
                        resultError = .noConnection

                    default:
                        resultError = .network(error: error, response: response)
                    }
                
                case .responseSerializationFailed, .responseValidationFailed:
                    resultError = .invalidResponse(error: afError, response: response)

                default:
                    resultError = .network(error: afError, response: response)
                }

            default:
                resultError = .network(error: error, response: response)
            }

            throw resultError
        }
    }
}
