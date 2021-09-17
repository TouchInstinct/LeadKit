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

import XCTest
@testable import TIFoundationUtils
    
final class TITimerTests: XCTestCase {
        
    // MARK: - Invalidation

    func test_thanDispatchSourceTimerIsInvalidated_whenIsStopped() {
        // given
        let expectation = expectation(description: "DispatchSourceTimer is invalidated")
        let timer = TITimer(type: .dispatchSourceTimer(queue: .main), mode: .onlyActive)

        // when
        timer.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            timer.invalidate()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        // then
        XCTAssertFalse(timer.isRunning)
        XCTAssertEqual(timer.elapsedTime, .zero)
    }
    
    func test_RunloopTimerIsInvalidated_whenIsStopped() {
        // given
        let expectation = expectation(description: "RunloopTimer is invalidated")
        let timer = TITimer(type: .runloopTimer(runloop: .main, mode: .default), mode: .onlyActive)

        // when
        timer.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            timer.invalidate()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        // then
        XCTAssertFalse(timer.isRunning)
        XCTAssertEqual(timer.elapsedTime, .zero)
    }
    
    // MARK: - Scheduling
    
    func test_thanIntervalIsCorrect_whenDispatchSourceTimerIsStopped() {
        // given
        let expectation = expectation(description: "DispatchSourceTimer is invalidated")
        let timer = TITimer(type: .dispatchSourceTimer(queue: .main), mode: .onlyActive)

        var elapsedTimes: [TimeInterval] = []
        
        timer.eventHandler = { [weak timer] in
            elapsedTimes.append($0)

            if $0 == 2 {
                timer?.invalidate()
                expectation.fulfill()
            }
        }
        
        let start = Date()

        // when
        timer.start()
        
        wait(for: [expectation], timeout: 5)
        
        // then
        let end = Date()

        XCTAssertEqual(2, end.timeIntervalSince(start), accuracy: 0.5)
        XCTAssertEqual(elapsedTimes, [0, 1, 2])
    }
    
    func test_thanIntervalIsCorrect_whenRunloopTimerIsStopped() {
        // given
        let expectation = expectation(description: "RunloopTimer is invalidated")
        let timer = TITimer(type: .runloopTimer(runloop: .current, mode: .default), mode: .onlyActive)

        var elapsedTimes: [TimeInterval] = []
        
        timer.eventHandler = { [weak timer] in
            elapsedTimes.append($0)

            if $0 == 2 {
                timer?.invalidate()
                expectation.fulfill()
            }
        }
        
        let start = Date()

        // when
        timer.start()
        
        wait(for: [expectation], timeout: 5)
        
        // then
        let end = Date()

        XCTAssertEqual(2, end.timeIntervalSince(start), accuracy: 0.5)
        XCTAssertEqual(elapsedTimes, [0, 1, 2])
    }
}
