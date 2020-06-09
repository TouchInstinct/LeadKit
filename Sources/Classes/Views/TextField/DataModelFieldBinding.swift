//
//  Copyright (c) 2018 Touch Instinct
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

import RxSwift
import RxCocoa

/// Class that maps data model field to String and vise-versa.
public final class DataModelFieldBinding<T> {

    public typealias GetFieldClosure = (T) -> String?
    public typealias MergeFieldClosure = (T, String?) -> T

    private let modelRelay: BehaviorRelay<T>
    private let modelDriver: Driver<T>
    private let getFieldClosure: DataModelFieldBinding<T>.GetFieldClosure
    private let mergeFieldClosure: DataModelFieldBinding<T>.MergeFieldClosure

    /// Memberwise initializer.
    ///
    /// - Parameters:
    ///   - modelRelay: BehaviourRelay that contains data model.
    ///   - modelDriver: Driver that emits new data models.
    ///   - getFieldClosure: Closure for getting field string reprerentation from data model.
    ///   - mergeFieldClosure: Closure for merging new field value into data model.
    public init(modelRelay: BehaviorRelay<T>,
                modelDriver: Driver<T>,
                getFieldClosure: @escaping GetFieldClosure,
                mergeFieldClosure: @escaping MergeFieldClosure) {

        self.modelRelay = modelRelay
        self.modelDriver = modelDriver
        self.getFieldClosure = getFieldClosure
        self.mergeFieldClosure = mergeFieldClosure
    }

    /// Method that merges new field values with data model.
    ///
    /// - Parameter textDriver: Driver that emits new text values.
    /// - Returns: Disposable object that can be used to unsubscribe the observer from the behaviour relay.
    public func mergeStringToModel(from textDriver: Driver<String?>) -> Disposable {
        return textDriver.map { [modelRelay, mergeFieldClosure] in
            mergeFieldClosure(modelRelay.value, $0)
        }
        .drive(modelRelay)
    }

    /// A Driver that will emit current field value.
    public var fieldDriver: Driver<String?> {
        return modelDriver.map(getFieldClosure)
    }
}

public extension DataModelFieldBinding {

    /// Convenience initializer without modelDriver, which will be obtained from modelRelay.
    ///
    /// - Parameters:
    ///   - modelRelay: BehaviourRelay that contains data model.
    ///   - getFieldClosure: Closure for getting field string reprerentation from data model.
    ///   - mergeFieldClosure: Closure for merging new field value into data model.
    convenience init(modelRelay: BehaviorRelay<T>,
                     getFieldClosure: @escaping GetFieldClosure,
                     mergeFieldClosure: @escaping MergeFieldClosure) {

        self.init(modelRelay: modelRelay,
                  modelDriver: modelRelay.asDriver(),
                  getFieldClosure: getFieldClosure,
                  mergeFieldClosure: mergeFieldClosure)
    }
}

public extension DataModelFieldBinding where T == String? {

    /// Convenience initializer for data model of string.
    ///
    /// - Parameter modelRelay: BehaviourRelay that contains data model.
    convenience init(modelRelay: BehaviorRelay<T>) {
        self.init(modelRelay: modelRelay,
                  modelDriver: modelRelay.asDriver(),
                  getFieldClosure: { $0 },
                  mergeFieldClosure: { $1 })
    }
}

public extension BehaviorRelay {

    /// Creates DataModelFieldBinding configured with given closures and behaviour relay itself.
    ///
    /// - Parameters:
    ///   - getFieldClosure: Closure for getting field string reprerentation from data model.
    ///   - mergeFieldClosure: Closure for merging new field value into data model.
    /// - Returns: DataModelFieldBinding instance.
    func fieldBinding(getFieldClosure: @escaping DataModelFieldBinding<Element>.GetFieldClosure,
                      mergeFieldClosure: @escaping DataModelFieldBinding<Element>.MergeFieldClosure)
        -> DataModelFieldBinding<Element> {

        return DataModelFieldBinding(modelRelay: self,
                                     getFieldClosure: getFieldClosure,
                                     mergeFieldClosure: mergeFieldClosure)
    }
}

public extension BehaviorRelay where Element == String? {

    /// Creates DataModelFieldBinding configured with behaviour relay itself.
    ///
    /// - Returns: DataModelFieldBinding instance.
    func fieldBinding() -> DataModelFieldBinding<Element> {
        return DataModelFieldBinding(modelRelay: self)
    }
}
