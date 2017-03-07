//
//  MappableUserDefaultsTests.swift
//  LeadKit
//
//  Created by Ivan Smolin on 28/02/2017.
//  Copyright © 2017 Touch Instinct. All rights reserved.
//

import XCTest
import LeadKit
import RxSwift

class MappableUserDefaultsTests: XCTestCase {

    lazy var post: Post = {
        return Post(userId: 1, id: 1, title: "First post", body: "")
    }()

    lazy var posts: [Post] = {
        return [Post(userId: 1, id: 1, title: "First post", body: ""),
                Post(userId: 1, id: 2, title: "Second post", body: ""),
                Post(userId: 2, id: 3, title: "Third post", body: ""),
                Post(userId: 2, id: 4, title: "Forth post", body: "")]
    }()

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
