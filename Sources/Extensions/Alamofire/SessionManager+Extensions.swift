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
    case unableToHandleQueryParams
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
                 headers: HTTPHeaders? = nil)
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
    ///   - additionalValidStatusCodes: set of additional valid status codes
    /// - Returns: Observable with request
    func apiRequest(requestParameters: ApiRequestParameters, additionalValidStatusCodes: Set<Int>) -> Observable<DataRequest> {
        return .deferred {
            var url = try requestParameters.url.asURL()

            if let queryItems = requestParameters.queryItems {
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return .error(RequestUsageError.unableToHandleQueryParams)
                }

                urlComponents.queryItems = queryItems
                url = try urlComponents.asURL()
            }

            let requestObservable: Observable<DataRequest>

            switch requestParameters.parameters {
            case .dictionary(let parameters)?:
                requestObservable = self.request(requestParameters.method,
                                                 url,
                                                 parameters: parameters,
                                                 encoding: requestParameters.encoding,
                                                 headers: requestParameters.headers)

            case .array(let parameters)?:
                guard let encoding = requestParameters.encoding as? JSONEncoding else {
                    assertionFailure("Invalid encoding type with array parameter")
                    return .error(RequestUsageError.urlEncodingForbidden)
                }

                requestObservable = self.request(requestParameters.method,
                                                 url,
                                                 parameters: parameters,
                                                 encoding: encoding,
                                                 headers: requestParameters.headers)

            case .none:
                requestObservable = self.request(requestParameters.method,
                                                 url,
                                                 parameters: nil as Parameters?,
                                                 encoding: requestParameters.encoding,
                                                 headers: requestParameters.headers)
            }

            return requestObservable
                .validate(statusCodes: self.base.acceptableStatusCodes.union(additionalValidStatusCodes))
        }
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameters:
    ///   - requestParameters: api parameters to pass Alamofire
    ///   - additionalValidStatusCodes: set of additional valid status codes
    ///   - decoder: json decoder to decode response data
    /// - Returns: Observable with HTTP URL Response and target object
    func responseModel<T: Decodable>(requestParameters: ApiRequestParameters,
                                     additionalValidStatusCodes: Set<Int>,
                                     decoder: JSONDecoder)
        -> Observable<SessionManager.ModelResponse<T>> {

        return apiRequest(requestParameters: requestParameters, additionalValidStatusCodes: additionalValidStatusCodes)
            .flatMap {
                $0.rx.apiResponse(mappingQueue: self.base.mappingQueue, decoder: decoder)
            }
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameters:
    ///   - requestParameters: api parameters to pass Alamofire
    ///   - additionalValidStatusCodes: set of additional valid status codes
    ///   - decoder: json decoder to decode response data
    /// - Returns: Observable with HTTP URL Response and target object
    func responseObservableModel<T: ObservableMappable>(requestParameters: ApiRequestParameters,
                                                        additionalValidStatusCodes: Set<Int>,
                                                        decoder: JSONDecoder)
        -> Observable<SessionManager.ModelResponse<T>> {

        return apiRequest(requestParameters: requestParameters, additionalValidStatusCodes: additionalValidStatusCodes)
            .flatMap {
                $0.rx.observableApiResponse(mappingQueue: self.base.mappingQueue, decoder: decoder)
            }
    }

    /// Method that executes request and returns data
    ///
    /// - Parameters:
    ///   - requestParameters: api parameters to pass Alamofire
    ///   - additionalValidStatusCodes: set of additional valid status codes
    /// - Returns: Observable with HTTP URL Response and Data
    func responseData(requestParameters: ApiRequestParameters, additionalValidStatusCodes: Set<Int>)
        -> Observable<SessionManager.DataResponse> {

            return apiRequest(requestParameters: requestParameters, additionalValidStatusCodes: additionalValidStatusCodes)
                .flatMap {
                    $0.rx.dataApiResponse(mappingQueue: self.base.mappingQueue)
                }
    }

    /// Method that executes upload request and serializes response into target object
    ///
    /// - Parameters:
    ///   - requestParameters: api upload parameters to pass Alamofire
    ///   - additionalValidStatusCodes: set of additional valid status codes
    ///   - decoder: json decoder to decode response data
    /// - Returns: Observable with HTTP URL Response and target object
    func uploadResponseModel<T: Decodable>(requestParameters: ApiUploadRequestParameters,
                                           additionalValidStatusCodes: Set<Int>,
                                           decoder: JSONDecoder)
        -> Observable<SessionManager.ModelResponse<T>> {

            return Observable.deferred {

                let urlRequest = try URLRequest(url: requestParameters.url, method: .post, headers: requestParameters.headers)
                let data = try requestParameters.formData.encode()

                return self.upload(data, urlRequest: urlRequest)
                    .map { $0 as DataRequest }
                    .validate(statusCodes: self.base.acceptableStatusCodes.union(additionalValidStatusCodes))
                    .flatMap {
                        $0.rx.apiResponse(mappingQueue: self.base.mappingQueue, decoder: decoder)
                    }
            }
    }
}
