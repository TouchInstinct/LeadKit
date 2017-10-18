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
import RxSwift

class CursorTests: XCTestCase {

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testStubCursor() {
        let entityCursor = StubCursor()

        let cursorExpectation = expectation(description: "Stub cursor expectation")

        entityCursor.loadNextBatch()
            .subscribe(onSuccess: { _ in
                cursorExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testFixedPageCursor() {
        let stubCursor = StubCursor(maxItemsCount: 15, requestDelay: .milliseconds(100))
        let fixedPageCursor = FixedPageCursor(cursor: stubCursor, pageSize: 16)

        let cursorExpectation = expectation(description: "Fixed page cursor expectation")

        fixedPageCursor.loadNextBatch()
            .subscribe(onSuccess: { loadedItems in
                XCTAssertEqual(loadedItems.count, 15)

                cursorExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMapCursorWithFixedPageCursor() {
        let stubCursor = StubCursor(maxItemsCount: 16, requestDelay: .milliseconds(100))
        let mapCursor = stubCursor.flatMap { $0.userId > 1 ? nil : $0 }
        let fixedPageCursor = FixedPageCursor(cursor: mapCursor, pageSize: 20)

        let cursorExpectation = expectation(description: "Fixed page cursor expectation")

        fixedPageCursor.loadNextBatch()
            .subscribe(onSuccess: { loadedItems in
                XCTAssertEqual(loadedItems.count, 8)

                cursorExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testStaticCursor() {
        let cursor = StaticCursor(content: Array(1...40).map(String.init))

        let cursorExpectation = expectation(description: "Static cursor expectation")

        cursor.loadNextBatch().subscribe(onSuccess: { loadedItems in
            XCTAssertEqual(loadedItems.count, 40)

            cursorExpectation.fulfill()
        }, onError: { error in
            XCTFail(error.localizedDescription)
        })
        .disposed(by: disposeBag)

        waitForExpectations(timeout: 10, handler: nil)
    }

}
