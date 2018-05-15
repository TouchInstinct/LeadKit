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

import ObjectMapper
import LeadKit
import RxSwift

struct ObservableMappablePost: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
    
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
}

extension ObservableMappablePost: ObservableMappable {
    
    static func createFrom(map: Map) -> Observable<ObservableMappablePost> {
        
        return Observable.deferredJust {
            let userId: Int = try map.value("userId")
            let postId: Int = try map.value("id")
            let title: String = try map.value("title")
            let body: String = try map.value("body")
            
            return ObservableMappablePost(userId: userId,
                                          postId: postId,
                                          title: title,
                                          body: body)
        }
    }
}

extension ObservableMappablePost: Equatable {
    
    static func == (lhs: ObservableMappablePost, rhs: ObservableMappablePost) -> Bool {
        return lhs.userId == rhs.userId &&
            lhs.postId == rhs.postId &&
            lhs.title == rhs.title &&
            lhs.body == rhs.body
    }
    
}

