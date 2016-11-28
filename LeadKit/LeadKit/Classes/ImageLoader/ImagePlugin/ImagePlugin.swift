//
//  ImagePlugin.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public protocol ImagePluginType {
    func perform(image: UIImage) -> Observable<UIImage>
    var pluginKey: String { get }
}

extension UIImage {
    public func performPlugins(plugins: [ImagePluginType]) -> Observable<UIImage> {
        var observable = Observable.just(self)
        
        for plugin in plugins {
            observable = observable.flatMap(plugin.perform)
        }
        
        return observable
    }
    
    public func performPlugins(plugins: ImagePluginType ...) -> Observable<UIImage> {
        return performPlugins(plugins: plugins)
    }
}
