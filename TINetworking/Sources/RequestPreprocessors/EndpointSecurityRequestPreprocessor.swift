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

import TIFoundationUtils

public protocol SecuritySchemePreprocessor {
    func preprocess<B,S>(request: EndpointRequest<B,S>,
                         using security: SecurityScheme,
                         completion: @escaping (Result<EndpointRequest<B,S>, Error>) -> Void) -> Cancellable
}

@available(iOS 13.0.0, *)
public extension SecuritySchemePreprocessor {
    func preprocess<B,S>(request: EndpointRequest<B,S>, using security: SecurityScheme) async -> Result<EndpointRequest<B,S>, Error> {
        await withTaskCancellableClosure { completion in
            preprocess(request: request, using: security) {
                completion($0)
            }
        }
    }
}
