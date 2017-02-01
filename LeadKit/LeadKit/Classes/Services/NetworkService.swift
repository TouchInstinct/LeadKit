//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper
import RxAlamofire

/// Base network service implementation build on top of LeadKit extensions for Alamofire.
/// Has an ability to automatically show / hide network activity indicator
/// and shows errors in DEBUG mode
open class NetworkService {

    private let disposeBag = DisposeBag()
    private let requestCount = Variable<Int>(0)

    public let sessionManager: Alamofire.SessionManager

    /// Let netwrok service automatically show / hide activity indicator
    public func bindActivityIndicator() {
        return requestCount.asDriver()
            .map { $0 != 0 }
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .addDisposableTo(disposeBag)
    }

    /// Creates new instance of NetworkService with given Alamofire session manager
    ///
    /// - Parameter sessionManager: Alamofire.SessionManager to use for requests
    public init(sessionManager: Alamofire.SessionManager) {
        self.sessionManager = sessionManager
    }

    /// Perform reactive request to get mapped ObservableMappable model and http response
    ///
    /// - Parameter parameters: api parameters to pass Alamofire
    /// - Returns: Observable of tuple containing (HTTPURLResponse, ObservableMappable)
    public func rxRequest<T: ObservableMappable>(with parameters: ApiRequestParameters)
        -> Observable<(response: HTTPURLResponse, model: T)> where T.ModelType == T {

            return sessionManager.rx.responseObservableModel(requestParameters: parameters)
                .counterTracking(for: self)
                .showErrorsInToastInDebugMode()
    }

    /// Perform reactive request to get mapped ImmutableMappable model and http response
    ///
    /// - Parameter parameters: api parameters to pass Alamofire
    /// - Returns: Observable of tuple containing (HTTPURLResponse, ImmutableMappable)
    public func rxRequest<T: ImmutableMappable>(with parameters: ApiRequestParameters)
        -> Observable<(response: HTTPURLResponse, model: T)> {

        return sessionManager.rx.responseModel(requestParameters: parameters)
            .counterTracking(for: self)
            .showErrorsInToastInDebugMode()
    }

    /// Perform reactive request to get UIImage and http response
    ///
    /// - Parameter url: An object adopting `URLConvertible`
    /// - Returns: Observable of tuple containing (HTTPURLResponse, UIImage?)
    public func rxLoadImage(url: String) -> Observable<(HTTPURLResponse, UIImage?)> {
        let request = RxAlamofire.requestData(.get, url, headers: [:])

        return request
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { (response, data) -> (HTTPURLResponse, UIImage?) in
                (response, UIImage(data: data))
            }
            .counterTracking(for: self)
            .showErrorsInToastInDebugMode()
    }

    fileprivate func increaseRequestCounter() {
        requestCount.value += 1
    }

    fileprivate func decreaseRequestCounter() {
        requestCount.value -= 1
    }

}

public extension Observable {

    /// Increase and descrease NetworkService request counter on subscribe and dispose
    /// (used to show / hide activity indicator)
    ///
    /// - Parameter networkService: NetworkService to operate on it
    /// - Returns: The source sequence with the side-effecting behavior applied.
    func counterTracking(for networkService: NetworkService) -> Observable<Observable.E> {
        return `do`(onSubscribe: {
            networkService.increaseRequestCounter()
        }, onDispose: {
            networkService.decreaseRequestCounter()
        })
    }
    
}
