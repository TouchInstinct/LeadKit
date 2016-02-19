//
//  ObjectsPool.swift
//  LeadKit
//
//  Created by Иван Смолин on 19/02/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// class that generates objects on initialization phase and then return its when necessary
public class ObjectsGenerator<T> {
    private var objects = [T]()
    
    private let poolSize: UInt
    
    typealias ObjectConstructor = () -> T
    
    private let objectsContructor: ObjectConstructor
    
    private let serialQueue = dispatch_queue_create("ru.touchin.LeadKit.ObjectsGenerator<\(T.self)>", DISPATCH_QUEUE_SERIAL)
    
    /**
     initializer function
     
     - parameter poolSize:   number of objects to generate
     - parameter contructor: objects constructor closure
     
     - returns: nothing
     */
    init(poolSize: UInt, objectsContructor contructor: ObjectConstructor) {
        self.poolSize = poolSize
        self.objectsContructor = contructor
        
        fillPool()
    }
    
    private func fillPool() {
        for _ in 0..<self.poolSize {
            self.objects.append(self.objectsContructor())
        }
    }
    
    /**
     method which returns object from pool
     
     - returns: object from pool
     */
    public func get() -> T {
        dispatch_sync(serialQueue) {
            if self.objects.count < 1 {
                self.fillPool()
            }
        }
        
        return self.objects.popLast()!
    }
    
}
