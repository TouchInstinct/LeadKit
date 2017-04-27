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
import ObjectMapper
import RxAlamofire

public extension Reactive where Base: DataRequest {

    /// Method which serializes response into target object
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func apiResponse<T: ImmutableMappable>(mappingQueue: DispatchQueue = .global())
        -> Observable<(response: HTTPURLResponse, model: T)> {

        return responseJSONOnQueue(mappingQueue)
            .map { resp, value in
                let json = try cast(value) as [String: Any]

                return (resp, try T(JSON: json))
            }
    }

    /// Method which serializes response into array of target objects
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and array of target objects
    func apiResponse<T: ImmutableMappable>(mappingQueue: DispatchQueue = .global())
        -> Observable<(response: HTTPURLResponse, models: [T])> {

            return responseJSONOnQueue(mappingQueue)
                .map { resp, value in
                    let jsonArray = try cast(value) as [[String: Any]]

                    return (resp, try Mapper<T>().mapArray(JSONArray: jsonArray))
            }
    }

    /// Method which serializes response into target object
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and target object
    func apiResponse<T: ObservableMappable>(mappingQueue: DispatchQueue = .global())
        -> Observable<(response: HTTPURLResponse, model: T)> where T.ModelType == T {

            return responseJSONOnQueue(mappingQueue)
                .flatMap { resp, value -> Observable<(response: HTTPURLResponse, model: T)> in
                let json = try cast(value) as [String: Any]

                return T.createFrom(map: Map(mappingType: .fromJSON, JSON: json))
                    .map { (resp, $0) }
            }
    }

    /// Method which serializes response into array of target objects
    ///
    /// - Parameter mappingQueue: The dispatch queue to use for mapping
    /// - Returns: Observable with HTTP URL Response and array of target objects
    func apiResponse<T: ObservableMappable>(mappingQueue: DispatchQueue = .global())
        -> Observable<(response: HTTPURLResponse, models: [T])> where T.ModelType == T {

            return responseJSONOnQueue(mappingQueue)
                .flatMap { resp, value -> Observable<(response: HTTPURLResponse, models: [T])> in
                    let jsonArray = try cast(value) as [[String: Any]]

                    let createFromList = jsonArray.map {
                        T.createFrom(map: Map(mappingType: .fromJSON, JSON: $0))
                    }

                    return Observable.zip(createFromList) { $0 }
                        .map { (resp, $0) }
            }
    }

    internal func responseJSONOnQueue(_ queue: DispatchQueue) -> Observable<(HTTPURLResponse, Any)> {
        return responseResult(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer(options: .allowFragments))
    }

}
