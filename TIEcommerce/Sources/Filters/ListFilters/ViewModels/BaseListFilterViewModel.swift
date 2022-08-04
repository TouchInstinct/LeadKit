//
//  Copyright (c) 2022 Touch Instinct
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

open class BaseListFilterViewModel<RowViewModelType: FilterRowRepresentable & Equatable>: FilterListPickerConfigurator {

    public typealias RowViewModel = RowViewModelType

    public var rowViewModels: [RowViewModelType]

    public weak var delegate: FiltersPickerDelegate?

    public var initiallySelectedValues: [RowViewModelType]?

    open var isFinishWithSeparator: Bool {
        true
    }

    open var isMultiselectionEnabled: Bool = false

    open var areInitiallySelectedValuesTheSame: Bool {
        guard let initiallySelectedValues = initiallySelectedValues else {
            return false
        }

        return initiallySelectedValues == selectedValues
    }

    open var areThereAnyValuesSelected: Bool {
        if let _ = rowViewModels.first(where: { $0.isSelected }) {
            return false
        }

        return true
    }

    open var selectedValues: [RowViewModelType] {
        rowViewModels.filter { $0.isSelected }
    }

    open var visibleValues: [RowViewModelType] {
        rowViewModels
    }

    open var visibleSelectedIndexes: [Int] {
        visibleValues.enumerated().compactMap {
            $0.element.isSelected ? $0.offset : nil
        }
    }

    public init(rowViewModels: [RowViewModelType], isMultiselectionEnabled: Bool) {
        self.rowViewModels = rowViewModels
        self.isMultiselectionEnabled = isMultiselectionEnabled
    }

    open func viewDidLoad() {
        initiallySelectedValues = selectedValues
    }

    open func setSelected(model: RowViewModelType, isSelected: Bool) {
        if !isMultiselectionEnabled {
            rowViewModels.enumerated().forEach {
                rowViewModels[$0.offset].isSelected = false
            }
        }

        if let index = rowViewModels.firstIndex(of: model) {
            rowViewModels[index].isSelected = isSelected
        }

        if !selectedValues.isEmpty {
            delegate?.filters(didSelect: selectedValues)
        }
    }
}
