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

import RxSwift
import RxAlamofire

public extension NetworkService {

    /// Perform reactive request to get UIImage and http response
    ///
    /// - Parameter url: An object adopting `URLConvertible`
    /// - Returns: Observable of tuple containing (HTTPURLResponse, UIImage?)
    func rxLoadImage(url: String) -> Observable<(HTTPURLResponse, UIImage?)> {
        let request = RxAlamofire.requestData(.get, url, headers: [:])

        return request
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { (response, data) -> (HTTPURLResponse, UIImage?) in
                (response, UIImage(data: data))
            }
            .counterTracking(for: self)
    }

}
