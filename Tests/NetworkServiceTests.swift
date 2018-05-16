//
//  Copyright (c) 2018 Touch Instinct
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

final class NetworkServiceTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        
        let configuration = NetworkServiceConfiguration(baseUrl: "")
        networkService = NetworkService(configuration: configuration)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        networkService = nil
        super.tearDown()
    }
    
    func testModelRequest() {
        // given
        let expectedModel = Album(userId: 1,
                                  albumId: 1,
                                  title: "quidem molestiae enim")
        
        var receivedModel: Album?
        var error: Error?
        let requestCompletedExpectation = expectation(description: "Request completed")
        let apiRequest = ApiRequestParameters(url: "https://jsonplaceholder.typicode.com/albums/1",
                                              headers: ["Content-Type": "application/json"])

        // when
        networkService.rxRequest(with: apiRequest)
            .subscribe(onNext: { (_, model: Album) in
                receivedModel = model
                requestCompletedExpectation.fulfill()
            }, onError: {
                error = $0
                requestCompletedExpectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 20, handler: nil)
        
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(receivedModel)
        XCTAssertEqual(receivedModel, expectedModel)
    }

    func testModelArrayRequest() {
        // given
        var response: [Album]?
        var error: Error?
        let requestCompletedExpectation = expectation(description: "Request completed")
        let apiRequest = ApiRequestParameters(url: "https://jsonplaceholder.typicode.com/albums",
                                              headers: ["Content-Type": "application/json"])

        //when
        networkService.rxRequest(with: apiRequest)
            .subscribe(onNext: { ( _, model: [Album]) in
                response = model
                requestCompletedExpectation.fulfill()
            }, onError: {
                error = $0
                requestCompletedExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 20, handler: nil)

        // then
        XCTAssertNil(error)
        XCTAssertNotNil(response)
        XCTAssert(response?.count == 100)
    }
    
    func testObservableModelRequest() {
        // given
        let expectedModel = Album(userId: 1,
                                  albumId: 1,
                                  title: "quidem molestiae enim")
        
        var receivedModel: Album?
        var error: Error?
        let requestCompletedExpectation = expectation(description: "Request completed")
        let apiRequest = ApiRequestParameters(url: "https://jsonplaceholder.typicode.com/albums/1",
                                              headers: ["Content-Type": "application/json"])
        
        // when
        networkService.rxRequest(with: apiRequest)
            .subscribe(onNext: { (_, model: Album) in
                receivedModel = model
                requestCompletedExpectation.fulfill()
            }, onError: {
                error = $0
                requestCompletedExpectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 20, handler: nil)
        
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(receivedModel)
        XCTAssertEqual(receivedModel, expectedModel)
    }

    func testObservableModelArrayRequest() {
        // given
        var receivedModel: AlbumContainer?
        var error: Error?
        let requestCompletedExpectation = expectation(description: "Request completed")
        let apiRequest = ApiRequestParameters(url: "https://jsonplaceholder.typicode.com/albums",
                                              headers: ["Content-Type": "application/json"])

        // when
        networkService.rxRequest(with: apiRequest)
            .subscribe(onNext: { (_, model: AlbumContainer) in
                receivedModel = model
                requestCompletedExpectation.fulfill()
            }, onError: {
                error = $0
                requestCompletedExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 20, handler: nil)

        //then
        XCTAssertNil(error)
        XCTAssertNotNil(receivedModel)
        XCTAssert(receivedModel?.albums.count == 100)
    }
}
