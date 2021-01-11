//
//  Copyright (c) 2018 Touch Instinct
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

import Foundation

public extension Encodable {

    func toJSON(with encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let data = try? encoder.encode(self) else {
            return [:]
        }

        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
            return [:]
        }

        return json
    }

    /// Method that converts encodable model to URLQueryItems array
    /// - Returns: URLQueryItems array
    func asUrlQueryItems() throws -> [URLQueryItem] {
        try toJSON().map {
            if ($1 is [String: Any] || $1 is [Any]),
                let jsonData = try? JSONSerialization.data(withJSONObject: $1, options: []),
                let jsonString = String(data: jsonData, encoding: .utf8) {
                return URLQueryItem(name: $0, value: jsonString)
            } else if let value = $1 as? CustomStringConvertible {
                return URLQueryItem(name: $0, value: value.description)
            } else {
                throw LeadKitError.failedToEncodeQueryItems
            }
        }
    }
}
