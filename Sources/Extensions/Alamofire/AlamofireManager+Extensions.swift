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
import ObjectMapper

public extension Alamofire.SessionManager {

    /// The default acceptable range 200...299
    static let defaultAcceptableStatusCodes = Set(200..<300)

}

public extension Reactive where Base: Alamofire.SessionManager {

    /// Method which executes request with given api parameters
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Returns: Observable with request
    func apiRequest(requestParameters: ApiRequestParameters,
                    acceptableStatusCodes: Set<Int> = Base.defaultAcceptableStatusCodes)
        -> Observable<DataRequest> {

        return request(requestParameters.method,
                       requestParameters.url,
                       parameters: requestParameters.parameters,
                       encoding: requestParameters.encoding,
                       headers: requestParameters.headers)
            .map { $0.validate(statusCode: acceptableStatusCodes) }
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func responseModel<T: ImmutableMappable>(requestParameters: ApiRequestParameters,
                                             mappingQueue: DispatchQueue = .global(),
                                             acceptableStatusCodes: Set<Int> = Base.defaultAcceptableStatusCodes)
        -> Observable<(response: HTTPURLResponse, model: T)> {

        return apiRequest(requestParameters: requestParameters, acceptableStatusCodes: acceptableStatusCodes)
            .flatMap { $0.rx.apiResponse(mappingQueue: mappingQueue) }
    }

    /// Method that executes request and serializes response into array of target objects
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and array of target objects
    func responseModel<T: ImmutableMappable>(requestParameters: ApiRequestParameters,
                                             mappingQueue: DispatchQueue = .global(),
                                             acceptableStatusCodes: Set<Int> = Base.defaultAcceptableStatusCodes)
        -> Observable<(response: HTTPURLResponse, models: [T])> {

        return apiRequest(requestParameters: requestParameters, acceptableStatusCodes: acceptableStatusCodes)
            .flatMap { $0.rx.apiResponse(mappingQueue: mappingQueue) }
    }

    /// Method that executes request and serializes response into target type
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func responseObject<T>(requestParameters: ApiRequestParameters,
                           mappingQueue: DispatchQueue = .global(),
                           acceptableStatusCodes: Set<Int> = Base.defaultAcceptableStatusCodes)
        -> Observable<(response: HTTPURLResponse, object: T)> {

            return apiRequest(requestParameters: requestParameters, acceptableStatusCodes: acceptableStatusCodes)
                .flatMap { $0.rx.apiResponse(mappingQueue: mappingQueue) }
    }

    /// Method that executes request and serializes response into target object
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func responseObservableModel<T: ObservableMappable>(requestParameters: ApiRequestParameters,
                                                        mappingQueue: DispatchQueue = .global(),
                                                        acceptableStatusCodes: Set<Int> = Base.defaultAcceptableStatusCodes)
        -> Observable<(response: HTTPURLResponse, model: T)> where T.ModelType == T {

        return apiRequest(requestParameters: requestParameters, acceptableStatusCodes: acceptableStatusCodes)
            .flatMap { $0.rx.observableApiResponse(mappingQueue: mappingQueue) }
    }

    /// Method that executes request and serializes response into array of target objects
    ///
    /// - Parameter requestParameters: api parameters to pass Alamofire
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and array of target objects
    func responseObservableModel<T: ObservableMappable>(requestParameters: ApiRequestParameters,
                                                        mappingQueue: DispatchQueue = .global(),
                                                        acceptableStatusCodes: Set<Int> = Base.defaultAcceptableStatusCodes)
        -> Observable<(response: HTTPURLResponse, models: [T])> where T.ModelType == T {

            return apiRequest(requestParameters: requestParameters, acceptableStatusCodes: acceptableStatusCodes)
                .flatMap { $0.rx.observableApiResponse(mappingQueue: mappingQueue) }
    }

}
