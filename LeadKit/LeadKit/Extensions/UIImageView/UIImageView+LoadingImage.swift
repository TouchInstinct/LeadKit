//
//  UIImageView+LoadingImage.swift
//  LeadKit
//
//  Created by Николай Ашанин on 28.09.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit
import QuartzCore

public extension UIImageView {

    /**
     loads an image from a URL. If cached, the cached image is returned.
     otherwise, a place holder is used until the image from web is returned by the closure.

     - parameter url: The image URL.
     - parameter placeholder: The placeholder image.
     - parameter fadeIn: Weather the mage should fade in.
     - parameter shouldCacheImage: Should be image cached.
     - parameter closure: Returns the image from the web the first time is fetched.
     
     - returns: A new image
     */
    public func imageFromURL(url: String,
                             placeholder: UIImage,
                             fadeIn: Bool = true,
                             shouldCacheImage: Bool = true,
                             closure: ((image: UIImage?) -> ())? = nil) {

        image = UIImage.imageFromURL(url,
                                     placeholder: placeholder,
                                     shouldCacheImage: shouldCacheImage) { [weak self]
                                        (uploadedImage: UIImage?) in

            guard let image = uploadedImage else {
                return nil
            }
            self?.image = image
            if fadeIn {
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                layer.addAnimation(transition, forKey: nil)
            }
            closure?(image: image)
        }
    }

}
