//
//  CursorTests.swift
//  LeadKit
//
//  Created by Ivan Smolin on 29/03/2017.
//  Copyright © 2017 Touch Instinct. All rights reserved.
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
            .subscribe(onNext: { _ in
                cursorExpectation.fulfill()
            })
            .addDisposableTo(disposeBag)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testFixedPageCursor() {
        let stubCursor = StubCursor(maxItemsCount: 15, requestDelay: .milliseconds(100))
        let fixedPageCursor = FixedPageCursor(cursor: stubCursor, pageSize: 16)

        let cursorExpectation = expectation(description: "Fixed page cursor expectation")
        let cursorExpectationError = expectation(description: "Fixed page cursor error expectation")

        fixedPageCursor.loadNextBatch()
            .subscribe(onNext: { loadedRange in
                XCTAssertEqual(fixedPageCursor[loadedRange].count, 15)

                cursorExpectation.fulfill()
            })
            .addDisposableTo(disposeBag)

        fixedPageCursor.loadNextBatch()
            .subscribe(onNext: { _ in
                XCTFail("Cursor should be exhausted!")
            }, onError: { error in
                switch try? cast(error) as CursorError {
                case .exhausted?:
                    cursorExpectationError.fulfill()
                default:
                    XCTFail("Cursor should be exhausted!")
                }
            })
            .addDisposableTo(disposeBag)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMapCursorWithFixedPageCursor() {
        let stubCursor = StubCursor(maxItemsCount: 16, requestDelay: .milliseconds(100))
        let mapCursor = stubCursor.flatMap { $0.userId > 1 ? nil : $0 }
        let fixedPageCursor = FixedPageCursor(cursor: mapCursor, pageSize: 20)

        let cursorExpectation = expectation(description: "Fixed page cursor expectation")

        fixedPageCursor.loadNextBatch()
            .subscribe(onNext: { loadedRange in
                XCTAssertEqual(fixedPageCursor[loadedRange].count, 8)

                cursorExpectation.fulfill()
            })
            .addDisposableTo(disposeBag)

        waitForExpectations(timeout: 10, handler: nil)
    }

}
