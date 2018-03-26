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

    private let modelVariable: Variable<T>
    private let modelDriver: Driver<T>
    private let getFieldClosure: DataModelFieldBinding<T>.GetFieldClosure
    private let mergeFieldClosure: DataModelFieldBinding<T>.MergeFieldClosure

    /// Memberwise initializer.
    ///
    /// - Parameters:
    ///   - modelVariable: Variable that contains data model.
    ///   - modelDriver: Driver that emits new data models.
    ///   - getFieldClosure: Closure for getting field string reprerentation from data model.
    ///   - mergeFieldClosure: Closure for merging new field value into data model.
    public init(modelVariable: Variable<T>,
                modelDriver: Driver<T>,
                getFieldClosure: @escaping GetFieldClosure,
                mergeFieldClosure: @escaping MergeFieldClosure) {

        self.modelVariable = modelVariable
        self.modelDriver = modelDriver
        self.getFieldClosure = getFieldClosure
        self.mergeFieldClosure = mergeFieldClosure
    }

    /// Method that merges new field values with data model.
    ///
    /// - Parameter textDriver: Driver that emits new text values.
    /// - Returns: Disposable object that can be used to unsubscribe the observer from the variable.
    public func mergeStringToModel(from textDriver: Driver<String?>) -> Disposable {
        return textDriver.map { [modelVariable, mergeFieldClosure] in
            mergeFieldClosure(modelVariable.value, $0)
        }
        .drive(modelVariable)
    }

    /// A Driver that will emit current field value.
    public var fieldDriver: Driver<String?> {
        return modelDriver.map(getFieldClosure)
    }

}

public extension DataModelFieldBinding {

    /// Convenience initializer without modelDriver, which will be obtained from modelVariable.
    ///
    /// - Parameters:
    ///   - modelVariable: Variable that contains data model.
    ///   - getFieldClosure: Closure for getting field string reprerentation from data model.
    ///   - mergeFieldClosure: Closure for merging new field value into data model.
    convenience init(modelVariable: Variable<T>,
                     getFieldClosure: @escaping GetFieldClosure,
                     mergeFieldClosure: @escaping MergeFieldClosure) {

        self.init(modelVariable: modelVariable,
                  modelDriver: modelVariable.asDriver(),
                  getFieldClosure: getFieldClosure,
                  mergeFieldClosure: mergeFieldClosure)
    }

}

public extension DataModelFieldBinding where T == String? {

    /// Convenience initializer for data model of string.
    ///
    /// - Parameter modelVariable: Variable that contains data model.
    convenience init(modelVariable: Variable<T>) {
        self.init(modelVariable: modelVariable,
                  modelDriver: modelVariable.asDriver(),
                  getFieldClosure: { $0 },
                  mergeFieldClosure: { $1 })
    }

}

public extension Variable {

    /// Creates DataModelFieldBinding configured with given closures and variable itself.
    ///
    /// - Parameters:
    ///   - getFieldClosure: Closure for getting field string reprerentation from data model.
    ///   - mergeFieldClosure: Closure for merging new field value into data model.
    /// - Returns: DataModelFieldBinding instance.
    func fieldBinding(getFieldClosure: @escaping DataModelFieldBinding<E>.GetFieldClosure,
                      mergeFieldClosure: @escaping DataModelFieldBinding<E>.MergeFieldClosure) -> DataModelFieldBinding<E> {

        return DataModelFieldBinding(modelVariable: self,
                                     getFieldClosure: getFieldClosure,
                                     mergeFieldClosure: mergeFieldClosure)
    }

}

public extension Variable where Element == String? {

    /// Creates DataModelFieldBinding configured with variable itself.
    ///
    /// - Returns: DataModelFieldBinding instance.
    func fieldBinding() -> DataModelFieldBinding<E> {
        return DataModelFieldBinding(modelVariable: self)
    }

}
