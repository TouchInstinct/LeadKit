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
