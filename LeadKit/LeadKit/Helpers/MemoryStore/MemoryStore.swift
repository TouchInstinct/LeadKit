//
//  MemoryStore.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

public class MemoryStore<TKey: Hashable, TData> {
    public typealias KeyType = TKey
    public typealias DataType = TData
    
    private var syncLock = Sync.Lock()
    private var dictionaryStore: [KeyType : DataType] = [:]
    private let clearOnMemoryWarning: Bool
    
    public init(clearOnMemoryWarning: Bool = false) {
        self.clearOnMemoryWarning = clearOnMemoryWarning
        
        if clearOnMemoryWarning {
            NotificationCenter.default.addObserver(self, selector: #selector(onMemoryWarning),
                                                   name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: UIApplication.shared)
        }
    }
    
    public func removeAllData() {
        syncLock.sync {
            return dictionaryStore.removeAll()
        }
    }
    
    public func loadData(key: KeyType) -> DataType? {
        return syncLock.sync {
            return dictionaryStore[key]
        }
    }
    
    public func storeData(key: TKey, data: DataType?) {
        syncLock.sync {
            guard let data = data else {
                dictionaryStore.removeValue(forKey: key)
                return
            }
            
            dictionaryStore[key] = data
        }
    }
    
    @objc private func onMemoryWarning() {
        removeAllData()
    }
    
    deinit {
        if clearOnMemoryWarning {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: UIApplication.shared)
        }
    }
}
