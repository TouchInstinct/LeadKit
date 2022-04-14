//
//  Copyright (c) 2022 Touch Instinct
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

import TINetworking
import TIFoundationUtils
import Cache
import Foundation

public struct EndpointCacheService<Content: Codable> {
    private let serializedRequest: SerializedRequest
    private let multiLevelStorage: Storage<SerializedRequest, Content>

    public var cachedContent: Content? {
        get {
            guard let entry = try? multiLevelStorage.entry(forKey: serializedRequest), !entry.expiry.isExpired else {
                try? multiLevelStorage.removeObject(forKey: serializedRequest)
                return nil
            }

            return entry.object
        }
        nonmutating set {
            if let object = newValue {
                try? multiLevelStorage.setObject(object,
                                                 forKey: serializedRequest)
            } else {
                try? multiLevelStorage.removeObject(forKey: serializedRequest)
            }
        }
    }

    public init(serializedRequest: SerializedRequest,
                cacheLifetime: TimeInterval,
                jsonCodingConfigurator: JsonCodingConfigurator) throws {

        self.serializedRequest = serializedRequest

        let nameWithoutLeadingSlash: String

        if serializedRequest.path.starts(with: "/") {
            nameWithoutLeadingSlash = serializedRequest.path.drop { $0 == "/" }.string
        } else {
            nameWithoutLeadingSlash = serializedRequest.path
        }

        let diskConfig = DiskConfig(name: nameWithoutLeadingSlash,
                                    expiry: .seconds(cacheLifetime))
        let memoryConfig = MemoryConfig(expiry: .seconds(cacheLifetime),
                                        countLimit: 0,
                                        totalCostLimit: 0)

        let transformer = Transformer {
            try jsonCodingConfigurator.jsonEncoder.encode($0)
        } fromData: {
            try jsonCodingConfigurator.jsonDecoder.decode(Content.self, from: $0)
        }

        self.multiLevelStorage = try Storage(diskConfig: diskConfig,
                                             memoryConfig: memoryConfig,
                                             transformer: transformer)
    }
}
