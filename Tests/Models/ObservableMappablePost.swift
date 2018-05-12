//
//  ObservableMappablePost.swift
//  LeadKit
//
//  Created by Andrey Ovsyannikov on 12.05.2018.
//  Copyright © 2018 Touch Instinct. All rights reserved.
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

