//
//  Copyright (c) 2021 Touch Instinct
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

import Alamofire

open class BaseUrlParameterEncoding {
    private let encoding: URLEncoding = .queryString

    public init() {}

    open func encode<L: ParameterLocation>(parameters: [String: Parameter<L>]) -> [KeyValueTuple<String, String>] {
        var filteredComponents: [KeyValueTuple<String, String>] = []

        for key in parameters.keys.sorted(by: <) {
            guard let parameter = parameters[key], let value = parameter.value else {
                continue
            }

            let components = encoding.queryComponents(fromKey: key, value: value)
                // filter components with empty values if parameter doesn't allow empty value
                .filter { !$0.1.isEmpty || parameter.allowEmptyValue }

            filteredComponents.append(contentsOf: components)
        }

        return filteredComponents
    }
}
