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

import Foundation

extension URL {
    func matches(_ regex: NSRegularExpression) -> Bool {
        let range = NSRange(location: 0, length: absoluteString.utf16.count)
        return regex.firstMatch(in: absoluteString, range: range) != nil
    }

    func validate(by component: URLComponent) -> Bool {
        switch component {
        case let .host(host):
            return self.host == host

        case let .absolutePath(path):
            return absoluteString == path

        case let .query(query):
            if let urlQuery = self.query {
                return urlQuery.contains(query)
            }
            return false
        }
    }
}
