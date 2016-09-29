//
//  UIImage+Loading.swift
//  LeadKit
//
//  Created by Николай Ашанин on 28.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit
import QuartzCore
import CoreGraphics
import Accelerate

public enum UIImageContentMode {
    case ScaleToFill, ScaleAspectFit, ScaleAspectFill
}

struct StaticSharedCache {
    static var sharedCache: NSCache? = nil
    static var onceToken: dispatch_once_t = 0
}

public extension UIImage {

    /**
     a singleton shared NSURL cache used for images from URL
     
     - returns: shared image cache
     */
    private class func sharedCache() -> NSCache {
        dispatch_once(&StaticSharedCache.onceToken) {
            StaticSharedCache.sharedCache = NSCache()
        }
        return StaticSharedCache.sharedCache
    }

    // MARK: Image From URL

    /**
     creates a new image from a URL with optional caching.
     if cached, the cached image is returned.
     otherwise, a place holder is used until the image from web is returned by the closure.

     - parameter url: The image URL.
     - parameter placeholder: The placeholder image.
     - parameter shouldCacheImage: Weather or not we should cache the NSURL response (default: true)
     - parameter closure: Returns the image from the web the first time is fetched.

     - returns: A new image
     */
    public class func imageFromURL(url: String,
                                   placeholder: UIImage,
                                   shouldCacheImage: Bool = true,
                                   closure: (image: UIImage?) -> ()) -> UIImage? {
        // From Cache
        if shouldCacheImage {
            if let image = UIImage.sharedCache().objectForKey(url) as? UIImage {
                closure(image: nil)
                return image
            }
        }
        // Fetch Image
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        if let nsURL = NSURL(string: url) {
            session.dataTaskWithURL(nsURL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        closure(image: nil)
                    }
                }
                if let data = data, image = UIImage(data: data) {
                    if shouldCacheImage {
                        UIImage.sharedCache().setObject(image, forKey: url)
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        closure(image: image)
                    }
                }
                session.finishTasksAndInvalidate()
            }).resume()
        }
        return placeholder
    }

}
