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

import LeadKit
import RxSwift

struct Album: Decodable {

    enum CodingKeys: String, CodingKey {
        case userId
        case albumId = "id"
        case title
    }

    let userId: Int
    let albumId: Int
    let title: String
}

extension Album: Equatable {

    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.userId == rhs.userId &&
            lhs.albumId == rhs.albumId &&
            lhs.title == rhs.title
    }
}

extension Album: ObservableMappable {

    static func create(from jsonObject: Any, with decoder: JSONDecoder) -> Observable<Album> {
        return Observable.deferredJust {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            return try decoder.decode(Album.self, from: data)
        }
    }
}
