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

import XCTest
import LeadKit

final class StringExtensionTests: XCTestCase {

    func testLocalizedComponent() {
        // swiftlint:disable cyrillic_strings
        let localizedOne = "версия"
        let localizedTwo = "версии"
        let localizedMany = "версий"
        // swiftlint:enable cyrillic_strings

        XCTAssertTrue(String.localizedComponent(value: 1,
                                                stringOne: localizedOne,
                                                stringTwo: localizedTwo,
                                                stringMany: localizedMany) == localizedOne)

        XCTAssertTrue(String.localizedComponent(value: 2,
                                                stringOne: localizedOne,
                                                stringTwo: localizedTwo,
                                                stringMany: localizedMany) == localizedTwo)

        XCTAssertTrue(String.localizedComponent(value: 25,
                                                stringOne: localizedOne,
                                                stringTwo: localizedTwo,
                                                stringMany: localizedMany) == localizedMany)
    }

}
