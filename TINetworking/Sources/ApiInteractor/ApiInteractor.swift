//
//  Copyright (c) 2022 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import TISwiftUtils
import TIFoundationUtils

public protocol ApiInteractor {
    associatedtype NetworkError

    typealias RequestResult<S: Decodable, AE: Decodable> = EndpointRequestResult<S, AE, NetworkError>

    func process<B: Encodable, S: Decodable, AE: Decodable, R>(request: EndpointRequest<B, S>,
                                                               mapSuccess: @escaping Closure<S, R>,
                                                               mapFailure: @escaping Closure<AE, R>,
                                                               mapNetworkError: @escaping Closure<NetworkError, R>,
                                                               completion: @escaping ParameterClosure<R>) -> Cancellable
}

@available(iOS 13.0.0, *)
public extension ApiInteractor {
    func process<B: Encodable, S, F>(request: EndpointRequest<B, S>) async -> RequestResult<S, F> {
        await process(request: request,
                      mapSuccess: Result.success,
                      mapFailure: { .failure(.apiError($0)) },
                      mapNetworkError: { .failure(.networkError($0)) })
    }

    func process<B: Encodable, S: Decodable, F: Decodable, R>(request: EndpointRequest<B, S>,
                                                                     mapSuccess: @escaping Closure<S, R>,
                                                                     mapFailure: @escaping Closure<F, R>,
                                                                     mapNetworkError: @escaping Closure<NetworkError, R>) async -> R {

        let cancellableBag = BaseCancellableBag()

        return await withTaskCancellationHandler(handler: {
            cancellableBag.cancel()
        }, operation: {
            await withCheckedContinuation { continuation in
                process(request: request,
                        mapSuccess: mapSuccess,
                        mapFailure: mapFailure,
                        mapNetworkError: mapNetworkError) {

                    continuation.resume(returning: $0)
                }
                .add(to: cancellableBag)
            }
        })
    }
}
