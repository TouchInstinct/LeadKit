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

class MappableUserDefaultsTests: XCTestCase {

    lazy var post: Post = {
        return Post(userId: 1, postId: 1, title: "First post", body: "")
    }()

    let posts = Post.generate()

    let userDefaults = UserDefaults.standard

    static let postKey = "post"
    static let postsKey = "posts"

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        userDefaults.set(nil, forKey: MappableUserDefaultsTests.postKey)
        userDefaults.set(nil, forKey: MappableUserDefaultsTests.postsKey)

        super.tearDown()
    }

    func testPostSave() {
        userDefaults.set(model: post, forKey: MappableUserDefaultsTests.postKey)

        do {
            let savedPost: Post = try userDefaults.object(forKey: MappableUserDefaultsTests.postKey)

            XCTAssertTrue(savedPost == post, "Saved post != test post")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testPostsSave() {
        userDefaults.set(models: posts, forKey: MappableUserDefaultsTests.postsKey)

        do {
            let savedPosts: [Post] = try userDefaults.objects(forKey: MappableUserDefaultsTests.postsKey)

            XCTAssertTrue(savedPosts == posts, "Saved posts != test posts")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testRxPostSave() {
        userDefaults.rx.set(model: post, forKey: MappableUserDefaultsTests.postKey)
            .flatMap {
                self.userDefaults.rx.object(forKey: MappableUserDefaultsTests.postKey) as Observable<Post>
            }
            .subscribe(onNext: { savedPost in
                XCTAssertTrue(savedPost == self.post, "Saved post != test post")
            }, onError: { error in
                XCTFail(error.localizedDescription)
            })
            .addDisposableTo(disposeBag)
    }

    func testRxPostsSave() {
        userDefaults.rx.set(models: posts, forKey: MappableUserDefaultsTests.postsKey)
            .flatMap {
                self.userDefaults.rx.object(forKey: MappableUserDefaultsTests.postsKey) as Observable<[Post]>
            }
            .subscribe(onNext: { savedPosts in
                XCTAssertTrue(savedPosts == self.posts, "Saved posts != test posts")
            }, onError: { error in
                XCTFail(error.localizedDescription)
            })
            .addDisposableTo(disposeBag)
    }

}
