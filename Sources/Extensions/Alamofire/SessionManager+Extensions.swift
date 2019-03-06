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

/// Enum that represents wrong usage of requset parameters
///
/// - getMethodForbidden: invalid usage of get method
/// - urlEncodingForbidden: invalid usage of URLEncoding
enum RequestUsageError: Error {

    case getMethodForbidden
    case urlEncodingForbidden
}

public extension Reactive where Base: SessionManager {

    /// Creates an observable of the `Request`.
    ///
    /// - Parameters:
    ///   - method: Alamofire method object
    ///   - url: An object adopting `URLConvertible`
    ///   - parameters: An array of JSON objects containing all necessary options
    ///   - encoding: The kind of encoding used to process parameters
    ///   - headers: A dictionary containing all the additional headers
    /// - Returns: An observable of the `Request`
    func request(_ method: Alamofire.HTTPMethod,
                 _ url: URLConvertible,
                 parameters: [Any]? = nil,
                 encoding: JSONEncoding = .default,
                 headers: [String: String]? = nil)
        -> Observable<DataRequest> {

        return Observable.deferred {

            guard method != .get else {
                assertionFailure("Unable to pass array in get request")
                throw RequestUsageError.getMethodForbidden
            }

            let urlRequest = try URLRequest(url: try url.asURL(), method: method, headers: headers)
            let encodedUrlRequest = try encoding.encode(urlRequest, withJSONObject: parameters)

            return self.request(urlRequest: encodedUrlRequest)
        }
    }

    /// Method which executes request with given api parameters
    ///
    /// - Parameters:
    ///   - requestParameters: api parameters to pass Alamofire
    ///   - validStatusCodes: set of additional valid status codes
    /// - Returns: Observable with request
    func apiRequest(requestParameters: ApiRequestParameters, validStatusCodes: Set<Int>)
        -> Observable<DataRequest> {

        let requestObservable: Observable<DataRequest>

        switch requestParameters.parameters {
        case .dictionary(let parameters)?:
            requestObservable = request(requestParameters.method,
                                        requestParameters.url,
                                        parameters: parameters,
                                        encoding: requestParameters.encoding,
                                        headers: requestParameters.headers)

        case .array(let parameters)?:
            guard let encoding = requestParameters.encoding as? JSONEncoding else {
                assertionFailure("Invalid encoding type with array parameter")
                return .error(RequestUsageError.urlEncodingForbidden)
            }

            requestObservable = request(requestParameters.method,
                                        requestParameters.url,
                                        parameters: parameters,
                                        encoding: encoding,
                                        headers: requestParameters.headers)

        case .none:
            requestObservable = request(requestParameters.method,
                                        requestParameters.url,
                                        parameters: nil as Parameters?,
                                        encoding: requestParameters.encoding,
                                        headers: requestParameters.headers)
        }

        return requestObservable
            .map { $0.validate(statusCode: self.base.acceptableStatusCodes.union(validStatusCodes)) }
            .catchAsRequestError()
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameters:
    ///   - requestParameters: api parameters to pass Alamofire
    ///   - validStatusCodes: set of additional valid status codes
    ///   - decoder: json decoder to decode response data
    /// - Returns: Observable with HTTP URL Response and target object
    func responseModel<T: Decodable>(requestParameters: ApiRequestParameters,
                                     validStatusCodes: Set<Int>,
                                     decoder: JSONDecoder)
        -> Observable<SessionManager.ModelResponse<T>> {

        return apiRequest(requestParameters: requestParameters, validStatusCodes: validStatusCodes)
            .flatMap {
                $0.rx.apiResponse(mappingQueue: self.base.mappingQueue, decoder: decoder)
                    .catchAsRequestError(with: $0)
            }
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameters:
    ///   - requestParameters: api parameters to pass Alamofire
    ///   - validStatusCodes: set of additional valid status codes
    ///   - decoder: json decoder to decode response data
    /// - Returns: Observable with HTTP URL Response and target object
    func responseObservableModel<T: ObservableMappable>(requestParameters: ApiRequestParameters,
                                                        validStatusCodes: Set<Int>,
                                                        decoder: JSONDecoder)
        -> Observable<SessionManager.ModelResponse<T>> {

        return apiRequest(requestParameters: requestParameters, validStatusCodes: validStatusCodes)
            .flatMap {
                $0.rx.observableApiResponse(mappingQueue: self.base.mappingQueue, decoder: decoder)
                    .catchAsRequestError(with: $0)
            }
    }

    /// Method that executes request and returns data
    ///
    /// - Parameters:
    ///   - requestParameters: api parameters to pass Alamofire
    ///   - validStatusCodes: set of additional valid status codes
    /// - Returns: Observable with HTTP URL Response and Data
    func responseData(requestParameters: ApiRequestParameters, validStatusCodes: Set<Int>)
        -> Observable<SessionManager.DataResponse> {

            return apiRequest(requestParameters: requestParameters, validStatusCodes: validStatusCodes)
                .flatMap {
                    $0.rx.responseResult(queue: self.base.mappingQueue,
                                         responseSerializer: DataRequest.dataResponseSerializer())
                        .map { $0 as SessionManager.DataResponse }
                        .catchAsRequestError(with: $0)
                }
    }
}

private extension ObservableType {
    func catchAsRequestError(with request: DataRequest? = nil) -> Observable<E> {
        return catchError { error in
            let resultError: RequestError
            let response = request?.delegate.data

            switch error {
            case let requestError as RequestError:
                resultError = requestError

            case let urlError as URLError:
                switch urlError.code {
                case .notConnectedToInternet:
                    resultError = .noConnection

                default:
                    resultError = .network(error: urlError, response: response)
                }

            case let afError as AFError:
                switch afError {
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
