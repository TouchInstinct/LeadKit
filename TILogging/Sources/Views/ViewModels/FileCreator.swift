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

public struct FileCreator {

    public var fileName: String
    public var fileExtension: String

    public var fullFileName: String {
        fileName + "." + fileExtension
    }

    public init(fileName: String, fileExtension: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
    }

    @discardableResult
    public func createFile(withData data: Data) -> Result<URL, Error> {
        let result = getDocumentsDirectory()

        guard case var .success(url) = result else {
            return result
        }

        url.appendPathComponent(fullFileName)

        do {
            try data.write(to: url)
            return .success(url)
            
        } catch {
            return .failure(error)
        }

    }

    public func getDocumentsDirectory() -> Result<URL, Error> {
        Result {
            try FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
        }
    }
}
