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

class Double_RoundingTests: XCTestCase {
    
    func testPositiveNumbers() {
        let pi = 3.1415926
        
        XCTAssertTrue(pi.roundValue(withPrecision: 0) == 3.0)
        XCTAssertTrue(pi.roundValue(withPrecision: 1) == 3.1)
        XCTAssertTrue(pi.roundValue(withPrecision: 2) == 3.14)
        XCTAssertTrue(pi.roundValue(withPrecision: 3) == 3.142)
        
        let some = 1.778297
        XCTAssertTrue(some.roundValue(withPrecision: 1) == 1.8)
        XCTAssertTrue(some.roundValue(withPrecision: 1, roundType: .down) == 1.7)
        XCTAssertTrue(some.roundValue(withPrecision: 2, roundType: .down) == 1.77)
    }
    
    func testNegativeNumbers() {
        let e = 2.7182
        
        XCTAssertTrue(-e.roundValue(withPrecision: 0) == -3.0)
        XCTAssertTrue(-e.roundValue(withPrecision: 1) == -2.7)
        XCTAssertTrue(-e.roundValue(withPrecision: 2) == -2.72)
        XCTAssertTrue(-e.roundValue(withPrecision: 3) == -2.718)
        
        let some = -1.778297
        XCTAssertTrue(some.roundValue(withPrecision: 1) == -1.8)
        XCTAssertTrue(some.roundValue(withPrecision: 1, roundType: .down) == -1.8)
        XCTAssertTrue(some.roundValue(withPrecision: 2, roundType: .down) == -1.78)
    }
}
