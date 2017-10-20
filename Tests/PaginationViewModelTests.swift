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
import CocoaLumberjack

class PaginationViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let cursor = StubCursor(maxItemsCount: 36, requestDelay: .seconds(1))
        let viewModel = PaginationViewModel(cursor: cursor)

        let paginationExpectation = expectation(description: "Pagination expectation")

        viewModel.state.drive(onNext: { state in
            switch state {
            case .initial, .loadingMore, .loading:
                DDLogDebug("PageViewModel state changed to \(state)")
            case .results(let newItems, _, _):
                XCTAssertEqual(newItems.count, 4)
                paginationExpectation.fulfill()
            default:
                XCTFail("Unexpected state: \(state)")
            }
        })
        .disposed(by: disposeBag)

        viewModel.load(.reload)

        waitForExpectations(timeout: 10, handler: nil)
    }

}
