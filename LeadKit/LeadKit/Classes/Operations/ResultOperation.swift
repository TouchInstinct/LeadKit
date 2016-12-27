//
//  ResultOperation.swift
//  LeadKit
//
//  Created by Ivan Smolin on 23/12/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/// Subclass of Operation which contains result of executed operation
public class ResultOperation<T>: Operation {

    /// Result of executed operation or nil if operation is not finished yet or throw error
    public var result: T?

    public typealias ExecutionClosure = () throws -> T

    private let executionClosure: ExecutionClosure

    public init(executionClosure: @escaping ExecutionClosure) {
        self.executionClosure = executionClosure
    }

    override public func main() {
        result = try? executionClosure()
    }
    
}
