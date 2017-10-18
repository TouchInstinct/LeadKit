//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import ObjectMapper
import RxSwift

/// A type representing an possible errors that can be thrown during fetching
/// model or array of specified type from UserDefaults.
///
/// - noSuchValue:          there is no such value for given key
/// - unableToMap:          the value cannot be mapped to given type for some reason
public enum UserDefaultsError: Error {

    case noSuchValue(key: String)
    case unableToMap(mappingError: Error)

}

fileprivate typealias JSONObject = [String: Any]

public extension UserDefaults {

    fileprivate func storedValue<ST>(forKey key: String) throws -> ST {
        guard let objectForKey = object(forKey: key) else {
            throw UserDefaultsError.noSuchValue(key: key)
        }

        return try cast(objectForKey) as ST
    }

    /// Returns the object with specified type associated with the first occurrence of the specified default.
    ///
    /// - parameter key: A key in the current user's defaults database.
    ///
    /// - throws: One of cases in UserDefaultsError
    ///
    /// - returns: The object with specified type associated with the specified key,
    /// or throw exception if the key was not found.
    func object<T>(forKey key: String) throws -> T where T: ImmutableMappable {
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
    func objects<T>(forKey key: String) throws -> [T] where T: ImmutableMappable {
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
    func object<T>(forKey key: String, defaultValue: T) -> T where T: ImmutableMappable {
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
    func objects<T>(forKey key: String, defaultValue: [T]) -> [T] where T: ImmutableMappable {
        return (try? objects(forKey: key)) ?? defaultValue
    }

    /// Sets or removes the value of the specified default key in the standard application domain.
    ///
    /// - Parameters:
    ///   - model: The object with specified type to store or nil to remove it from the defaults database.
    ///   - key:   The key with which to associate with the value.
    func set<T>(model: T?, forKey key: String) where T: ImmutableMappable {
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
    func set<T, S>(models: S?, forKey key: String) where T: ImmutableMappable, S: Sequence, S.Iterator.Element == T {
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
        return Observable.deferredJust { try self.base.object(forKey: key) }
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
        return Observable.deferredJust { self.base.object(forKey: key, defaultValue: defaultValue) }
    }

    /// Reactive version of object<T>(forKey:) -> [T].
    ///
    /// - parameter key: A key in the current user's defaults database.
    ///
    /// - returns: Observable of specified array type.
    func object<T>(forKey key: String) -> Observable<[T]> where T: ImmutableMappable {
        return Observable.deferredJust { try self.base.objects(forKey: key) }
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
        return Observable.deferredJust { self.base.objects(forKey: key, defaultValue: defaultValue) }
    }

    /// Reactive version of set<T>(_:forKey:).
    ///
    /// Will never call onError(:) on observer.
    ///
    /// - parameter model: The object with specified type to store in the defaults database.
    /// - parameter key:   The key with which to associate with the value.
    ///
    /// - returns: Observable of Void type.
    func set<T>(model: T?, forKey key: String) -> Observable<Void> where T: ImmutableMappable {
        return Observable.create { observer in
            observer.onNext(self.base.set(model: model, forKey: key))
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
    func set<T, S>(models: S?, forKey key: String) -> Observable<Void>
        where T: ImmutableMappable, S: Sequence, S.Iterator.Element == T {

        return Observable.create { observer in
            observer.onNext(self.base.set(models: models, forKey: key))
            observer.onCompleted()

            return Disposables.create()
        }
    }

}
