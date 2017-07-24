//
//  Copyright (c) 2017 Touch Instinct
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

import ObjectMapper

public extension DateFormattingService {

    /// Creates transform for date to string and string to date mapping.
    ///
    /// - Parameter arguments: A formatting arguments structure.
    /// - Returns: A transform for given formatting arguments.
    func mappingTransform(for arguments: DateFormattingArguments) -> TransformOf<Date, String> {
        return TransformOf<Date, String>(fromJSON: { stringValue in
            if let stringValue = stringValue {
                return self.date(from: stringValue, arguments: arguments)
            } else {
                return nil
            }
        }, toJSON: { dateValue in
            if let dateValue = dateValue {
                return self.string(from: dateValue, arguments: arguments)
            } else {
                return nil
            }
        })
    }

}
