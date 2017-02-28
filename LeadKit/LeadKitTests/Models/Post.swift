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

import ObjectMapper

struct Post: ImmutableMappable {

    let userId: Int
    let id: Int
    let title: String
    let body: String

    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }

    init(map: Map) throws {
        userId = try map.value("userId")
        id = try map.value("id")
        title = try map.value("title")
        body = try map.value("body")
    }

    mutating func mapping(map: Map) {
        userId >>> map["userId"]
        id >>> map["id"]
        title >>> map["title"]
        body >>> map["body"]
    }
    
}

extension Post: Equatable {

    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.userId == rhs.userId &&
            lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.body == rhs.body
    }
    
}

