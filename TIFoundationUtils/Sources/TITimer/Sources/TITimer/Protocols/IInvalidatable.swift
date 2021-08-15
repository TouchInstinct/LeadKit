//
//  IInvalidatable.swift
//  
//
//  Created by Vlad Suhomlinov on 15.08.2021.
//

import UIKit

public protocol IInvalidatable: AnyObject {
    
    // Уничтожить объект
    func invalidate()
}

// MARK: - IInvalidatable

extension Timer: IInvalidatable { }

extension DispatchSource: IInvalidatable {
    
    public func invalidate() {
        setEventHandler(handler: nil)
        
        if !isCancelled {
            cancel()
        }
    }
}
