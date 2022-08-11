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

import Foundation
import TISwiftUtils

public protocol FilterViewModelProtocol: AnyObject {

    associatedtype PropertyValue: FilterPropertyValueRepresenter & Hashable
    associatedtype CellViewModelType: FilterCellViewModelProtocol & Hashable

    var values: [PropertyValue] { get set }
    var selectedValues: [PropertyValue] { get set }

    func filterDidSelected(atIndexPath indexPath: IndexPath) -> [(indexPath: IndexPath, viewModel: CellViewModelType)]
    func toggleProperty(atIndexPath indexPath: IndexPath) -> (selected: [PropertyValue], deselected: [PropertyValue])
}

public extension FilterViewModelProtocol {

    func toggleProperty(atIndexPath indexPath: IndexPath) -> (selected: [PropertyValue], deselected: [PropertyValue]) {
        guard let item = values[safe: indexPath.item] else { return ([], []) }

        return toggleProperty(item)
    }

    @discardableResult
    private func toggleProperty(_ value: PropertyValue) -> (selected: [PropertyValue], deselected: [PropertyValue]) {
        var valuesToDeselect = [PropertyValue]()
        var valuesToSelect = [PropertyValue]()
        let selectedValueId = selectedValues.firstIndex { selectedValue in
            selectedValue.id == value.id
        }

        if let selectedValueId = selectedValueId {
            // Removes previously selected filter
            selectedValues.remove(at: selectedValueId)
            valuesToDeselect.append(value)
        } else {
            // Selectes unselected filter
            selectedValues.append(value)
            valuesToSelect.append(value)

            // If the filter has filters to exclude, these filters marks as deselected
            let excludedValues = excludeValues(value)
            valuesToDeselect.append(contentsOf: excludedValues)
        }
        
        return (valuesToSelect, valuesToDeselect)
    }
    
    private func excludeValues(_ values: PropertyValue) -> [PropertyValue] {
        let valuesIdsToExclude = values.excludingPropertiesIds

        guard !valuesIdsToExclude.isEmpty else {
            return []
        }

        var excludedValues = [PropertyValue]()

        for valuesIdToExclude in valuesIdsToExclude {
            let propertyToExclude = selectedValues.first { property in
                property.id == valuesIdToExclude
            }

            if let propertyToExclude = propertyToExclude {
                let (_, deselected) = toggleProperty(propertyToExclude)
                excludedValues.append(contentsOf: deselected)
            }
        }

        return excludedValues
    }
}
