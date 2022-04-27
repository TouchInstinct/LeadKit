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

import UIKit.UIImage

open class DefaultCachableMarkerIconFactory<M, K: AnyObject>: DefaultMarkerIconFactory<M> {
    public typealias CacheKeyProvider = (M) -> K

    public let cache = NSCache<K, UIImage>()

    private let cacheKeyProvider: CacheKeyProvider

    public init(createIconClosure: @escaping CreateIconClosure,
                cacheKeyProvider: @escaping CacheKeyProvider) {

        self.cacheKeyProvider = cacheKeyProvider

        super.init(createIconClosure: createIconClosure)
    }

    open override func markerIcon(for model: M) -> UIImage {
        let cacheKey = cacheKeyProvider(model)

        guard let cachedIcon = cache.object(forKey: cacheKey) else {
            let icon = super.markerIcon(for: model)
            cache.setObject(icon, forKey: cacheKey)

            return icon
        }

        return cachedIcon
    }
}
