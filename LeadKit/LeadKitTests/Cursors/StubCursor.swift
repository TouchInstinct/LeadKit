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

import LeadKit
import RxSwift

class StubCursor: CursorType, ResettableCursorType {

    typealias LoadResultType = CountableRange<Int>

    typealias Element = Post

    private var posts: [Post] = []

    private let maxItemsCount: Int

    private let requestDelay: DispatchTimeInterval

    var count: Int {
        return posts.count
    }

    var exhausted: Bool {
        return count >= maxItemsCount
    }

    subscript(index: Int) -> Post {
        return posts[index]
    }

    init(maxItemsCount: Int = 12, requestDelay: DispatchTimeInterval = .seconds(2)) {
        self.maxItemsCount = maxItemsCount
        self.requestDelay = requestDelay
    }

    required init(initialFrom other: StubCursor) {
        self.maxItemsCount = other.maxItemsCount
        self.requestDelay = other.requestDelay
    }

    func loadNextBatch() -> Observable<CountableRange<Int>> {
        return Observable.create { observer -> Disposable in
            if self.exhausted {
                observer.onError(CursorError.exhausted)
            } else {
                DispatchQueue.global().asyncAfter(deadline: .now() + self.requestDelay, execute: {
                    let countBefore = self.count

                    let newPosts = Post.generate()

                    let maxNewPosts = min(self.maxItemsCount, countBefore + newPosts.count)

                    self.posts = Array((self.posts + newPosts)[0..<maxNewPosts])

                    observer.onNext(countBefore..<self.count)
                    observer.onCompleted()
                })
            }

            return Disposables.create()
        }
    }

}
