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

public struct OneOfMappingError: Error, CustomDebugStringConvertible {
    public typealias MappingFailures = [KeyValueTuple<Any.Type, Error>]

    public let codingPath: [CodingKey]
    public let mappingFailures: MappingFailures

    public init(codingPath: [CodingKey], mappingFailures: MappingFailures) {
        self.codingPath = codingPath
        self.mappingFailures = mappingFailures
    }

    public var debugDescription: String {
        var formattedString = "\"oneOf\" mapping failed for codingPath \(codingPath)\nwith following errors:\n"

        for (type, error) in mappingFailures {
            formattedString += "\(type) mapping failed with error: \(error)\n"
        }

        return formattedString
    }
}
