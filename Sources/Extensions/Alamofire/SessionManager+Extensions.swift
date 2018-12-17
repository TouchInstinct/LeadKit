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

public extension Reactive where Base: SessionManager {

    /**
     Creates an observable of the `Request`.
     
     - parameter method: Alamofire method object
     - parameter url: An object adopting `URLConvertible`
     - parameter parameters: An array of dictionaries containing all necessary options
     - parameter encoding: The kind of encoding used to process parameters
     - parameter header: A dictionary containing all the additional headers
     
     - returns: An observable of the `Request`
     */
    public func request(_ method: Alamofire.HTTPMethod,
                        _ url: URLConvertible,
                        parameters: [Parameters]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil
        )
        -> Observable<DataRequest>
    {
        return Observable.deferred {
            var urlRequest = URLRequest(url: try url.asURL())
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            return self.request(urlRequest: urlRequest)
        }
    }
    
    /// Method which executes request with given api parameters
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Returns: Observable with request
    func apiRequest(requestParameters: ApiRequestParameters)
        -> Observable<DataRequest> {
            
        let requestObservable: Observable<DataRequest>
            
        switch requestParameters.parameters {
        case .dictionary(let parameters):
            requestObservable = request(requestParameters.method,
                                        requestParameters.url,
                                        parameters: parameters,
                                        encoding: requestParameters.encoding,
                                        headers: requestParameters.headers)
        case .array(let parameters):
            requestObservable = request(requestParameters.method,
                                        requestParameters.url,
                                        parameters: parameters,
                                        encoding: requestParameters.encoding,
                                        headers: requestParameters.headers)
        }
            
        return requestObservable
            .map { $0.validate(statusCode: self.base.acceptableStatusCodes) }
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter decoder: json decoder to decode response data
    /// - Returns: Observable with HTTP URL Response and target object
    func responseModel<T: Decodable>(requestParameters: ApiRequestParameters,
                                     decoder: JSONDecoder)
        -> Observable<(response: HTTPURLResponse, model: T)> {

        return apiRequest(requestParameters: requestParameters)
            .flatMap {
                $0.rx.apiResponse(mappingQueue: self.base.mappingQueue, decoder: decoder)
                    .catchAsRequestError(with: $0)
            }
            .catchAsRequestError()
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter decoder: json decoder to decode response data
    /// - Returns: Observable with HTTP URL Response and target object
    func responseObservableModel<T: ObservableMappable>(requestParameters: ApiRequestParameters,
                                                        decoder: JSONDecoder)
        -> Observable<(response: HTTPURLResponse, model: T)> {

        return apiRequest(requestParameters: requestParameters)
            .flatMap {
                $0.rx.observableApiResponse(mappingQueue: self.base.mappingQueue, decoder: decoder)
                    .catchAsRequestError(with: $0)
            }
            .catchAsRequestError()
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
