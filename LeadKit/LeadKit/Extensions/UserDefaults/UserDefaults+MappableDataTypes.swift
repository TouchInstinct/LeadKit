//
//  UserDefaults+MappableDataTypes.swift
//  LeadKit
//
//  Created by Ivan Smolin on 26/10/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

/// A type representing an possible errors that can be thrown during fetching
/// model or array of specified type from UserDefaults.
///
/// - noSuchValue:          there is no such value for given key
/// - wrongStoredValueType: the stored value type is unsuitable for performing mapping with it
/// - unableToMap:          the value cannot be mapped to given type for some reason
public enum UserDefaultsError: Error {

    case noSuchValue(key: String)
    case wrongStoredValueType(expected: Any.Type, received: Any.Type)
    case unableToMap(mappingError: Error)
    
}

fileprivate typealias JSONObject = [String: Any]

public extension UserDefaults {

    fileprivate func storedValue<ST>(forKey key: String) throws -> ST {
        guard let objectForKey = object(forKey: key) else {
            throw UserDefaultsError.noSuchValue(key: key)
        }

        guard let storedValue = objectForKey as? ST else {
            throw UserDefaultsError.wrongStoredValueType(expected: ST.self, received: type(of: objectForKey))
        }

        return storedValue
    }

    /// Returns the object with specified type associated with the first occurrence of the specified default.
    ///
    /// - parameter key: A key in the current user's defaults database.
    ///
    /// - throws: One of cases in UserDefaultsError
    ///
    /// - returns: The object with specified type associated with the specified key,
    /// or throw exception if the key was not found.
    public func object<T>(forKey key: String) throws -> T where T: ImmutableMappable {
        let jsonObject = try storedValue(forKey: key) as JSONObject

        do {
            return try T(JSON: jsonObject)
        } catch {
            throw UserDefaultsError.unableToMap(mappingError: error)
        }
    }

    /// Returns the array of objects with specified type associated with the first occurrence of the specified default.
    ///
    /// - parameter key: A key in the current user's defaults database.
    ///
    /// - throws: One of cases in UserDefaultsError
    ///
    /// - returns: The array of objects with specified type associated with the specified key,
    /// or throw exception if the key was not found.
    public func object<T>(forKey key: String) throws -> [T] where T: ImmutableMappable {
        let jsonArray = try storedValue(forKey: key) as [JSONObject]

        do {
            return try jsonArray.map { try T(JSON: $0) }
        } catch {
            throw UserDefaultsError.unableToMap(mappingError: error)
        }
    }

    /// Returns the object with specified type associated with the first occurrence of the specified default.
    ///
    /// - parameter key:          A key in the current user's defaults database.
    /// - parameter defaultValue: A default value which will be used if there is no such value for specified key,
    /// or if error occurred during mapping
    ///
    /// - returns: The object with specified type associated with the specified key, or passed default value
    /// if there is no such value for specified key or if error occurred during mapping.
    public func object<T>(forKey key: String, defaultValue: T) -> T where T: ImmutableMappable {
        return (try? object(forKey: key)) ?? defaultValue
    }

    /// Returns the array of objects with specified type associated with the first occurrence of the specified default.
    ///
    /// - parameter key:          A key in the current user's defaults database.
    /// - parameter defaultValue: A default value which will be used if there is no such value for specified key,
    /// or if error occurred during mapping
    ///
    /// - returns: The array of objects with specified type associated with the specified key, or passed default value
    /// if there is no such value for specified key or if error occurred during mapping.
    public func object<T>(forKey key: String, defaultValue: [T]) -> [T] where T: ImmutableMappable {
        return (try? object(forKey: key)) ?? defaultValue
    }

    /// Sets or removes the value of the specified default key in the standard application domain.
    ///
    /// - Parameters:
    ///   - model: The object with specified type to store or nil to remove it from the defaults database.
    ///   - key:   The key with which to associate with the value.
    public func set<T>(_ model: T?, forKey key: String) where T: ImmutableMappable {
        if let model = model {
            set(model.toJSON(), forKey: key)
        } else {
            set(nil, forKey: key)
        }
    }

    /// Sets or removes the value of the specified default key in the standard application domain.
    ///
    /// - Parameters:
    ///   - models: The array of object with specified type to store or nil to remove it from the defaults database.
    ///   - key:    The key with which to associate with the value.
    public func set<T, S>(_ models: S?, forKey key: String) where T: ImmutableMappable, S: Sequence, S.Iterator.Element == T {
        if let models = models {
            set(models.map { $0.toJSON() }, forKey: key)
        } else {
            set(nil, forKey: key)
        }
    }

}

public extension Reactive where Base: UserDefaults {

    /// Reactive version of object<T>(forKey:) -> T.
    ///
    /// - parameter key: A key in the current user's defaults database.
    ///
    /// - returns: Observable of specified model type.
    func object<T>(forKey key: String) -> Observable<T> where T: ImmutableMappable {
        return Observable.create { observer in
            do {
                observer.onNext(try self.base.object(forKey: key))
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    /// Reactive version of object<T>(forKey:defaultValue:) -> T.
    ///
    /// Will never call onError(:) on observer.
    ///
    /// - parameter key:          A key in the current user's defaults database.
    /// - parameter defaultValue: A default value which will be used if there is no such value for specified key,
    /// or if error occurred during mapping
    ///
    /// - returns: Observable of specified model type.
    func object<T>(forKey key: String, defaultValue: T) -> Observable<T> where T: ImmutableMappable {
        return Observable.create { observer in
            observer.onNext(self.base.object(forKey: key, defaultValue: defaultValue))
            observer.onCompleted()

            return Disposables.create()
        }
    }

    /// Reactive version of object<T>(forKey:) -> [T].
    ///
    /// - parameter key: A key in the current user's defaults database.
    ///
    /// - returns: Observable of specified array type.
    func object<T>(forKey key: String) -> Observable<[T]> where T: ImmutableMappable {
        return Observable.create { observer in
            do {
                observer.onNext(try self.base.object(forKey: key))
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    /// Reactive version of object<T>(forKey:defaultValue:) -> [T].
    ///
    /// Will never call onError(:) on observer.
    ///
    /// - parameter key:          A key in the current user's defaults database.
    /// - parameter defaultValue: A default value which will be used if there is no such value for specified key,
    /// or if error occurred during mapping
    ///
    /// - returns: Observable of specified array type.
    func object<T>(forKey key: String, defaultValue: [T]) -> Observable<[T]> where T: ImmutableMappable {
        return Observable.create { observer in
            observer.onNext(self.base.object(forKey: key, defaultValue: defaultValue))
            observer.onCompleted()

            return Disposables.create()
        }
    }

    /// Reactive version of set<T>(_:forKey:).
    ///
    /// Will never call onError(:) on observer.
    ///
    /// - parameter model: The object with specified type to store in the defaults database.
    /// - parameter key:   The key with which to associate with the value.
    ///
    /// - returns: Observable of Void type.
    func set<T>(_ model: T?, forKey key: String) -> Observable<Void> where T: ImmutableMappable {
        return Observable.create { observer in
            observer.onNext(self.base.set(model, forKey: key))
            observer.onCompleted()

            return Disposables.create()
        }
    }

    /// Reactive version of set<T, S>(_:forKey:).
    ///
    /// Will never call onError(:) on observer.
    ///
    /// - parameter models: The array of object with specified type to store in the defaults database.
    /// - parameter key:    The key with which to associate with the value.
    ///
    /// - returns: Observable of Void type.
    func set<T, S>(_ models: S?, forKey key: String) -> Observable<Void>
        where T: ImmutableMappable, S: Sequence, S.Iterator.Element == T {

        return Observable.create { observer in
            observer.onNext(self.base.set(models, forKey: key))
            observer.onCompleted()

            return Disposables.create()
        }
    }

}
