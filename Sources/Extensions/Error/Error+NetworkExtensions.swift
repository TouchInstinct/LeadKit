//
//  Copyright (c) 2019 Touch Instinct
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

import RxSwift

public extension Error {

    var requestError: RequestError? {
        self as? RequestError
    }

    /// Method that tries to serialize response from a mapping request error to a model
    ///
    /// - Parameter decoder: json decoder to decode response data
    /// - Returns: optional target object
    /// - Throws: an error during decoding
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder()) throws -> T? {
        guard let self = requestError, case .mapping(_, let response, _) = self else {
            return nil
        }

        return try decoder.decode(T.self, from: response)
    }
}

public extension ObservableType {

    /// Method that handles a mapping error and serialize response to a model
    ///
    /// - Parameters:
    ///   - decoder: json decoder to decode response data
    ///   - handler: closure that recieves serialized response
    /// - Returns: Observable on caller
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder(),
                                          handler: @escaping ParameterClosure<T>) -> Observable<Element> {
            self.do(onError: { error in
                guard let errorModel = try error.handleMappingError(with: decoder) as T? else {
                    return
                }

                handler(errorModel)
            })
    }
}

public extension PrimitiveSequence where Trait == SingleTrait {

    /// Method that handles a mapping error and serialize response to a model
    ///
    /// - Parameters:
    ///   - decoder: json decoder to decode response data
    ///   - handler: closure that recieves serialized response
    /// - Returns: Single on caller
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder(),
                                          handler: @escaping ParameterClosure<T>) -> PrimitiveSequence<Trait, Element> {
            self.do(onError: { error in
                guard let errorModel = try error.handleMappingError(with: decoder) as T? else {
                    return
                }

                handler(errorModel)
            })
    }
}

public extension PrimitiveSequence where Trait == CompletableTrait, Element == Never {

    /// Method that handles a mapping error and serialize response to a model
    ///
    /// - Parameters:
    ///   - decoder: json decoder to decode response data
    ///   - handler: closure that recieves serialized response
    /// - Returns: Completable
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder(),
                                          handler: @escaping ParameterClosure<T>) -> Completable {
            self.do(onError: { error in
                guard let errorModel = try error.handleMappingError(with: decoder) as T? else {
                    return
                }

                handler(errorModel)
            })
    }
}
