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

public protocol FilterViewModelProtocol: AnyObject {

    associatedtype Property: FilterPropertyValueRepresenter, Hashable
    associatedtype CellViewModel: FilterCellViewModelProtocol & Hashable

    typealias Change = (indexPath: IndexPath, viewModel: CellViewModel)


    var properties: [Property] { get set }
    var selectedProperties: Set<Property> { get set }

    func filterDidSelected(atIndexPath indexPath: IndexPath) -> [Change]
    func toggleProperty(atIndexPath indexPath: IndexPath) -> (selected: [Property], deselected: [Property])
    func getCellsViewModels() -> [CellViewModel]
}

public extension FilterViewModelProtocol {

    func toggleProperty(atIndexPath indexPath: IndexPath) -> (selected: [Property], deselected: [Property]) {
        guard let item = getPropertySafely(indexPath.item) else { return ([], []) }

        return toggleProperty(item)
    }

    @discardableResult
    private func toggleProperty(_ property: Property) -> (selected: [Property], deselected: [Property]) {
        var propertiesToDeselect = [Property]()
        var propertiesToSelect = [Property]()
        let selectedProperty = selectedProperties.first { selectedProperty in
            selectedProperty.id == property.id
        }

        if let selectedProperty = selectedProperty {
            // Removes previously selected filter
            selectedProperties.remove(selectedProperty)
            propertiesToDeselect.append(property)
        } else {
            // Selectes unselected filter
            selectedProperties.insert(property)
            propertiesToSelect.append(property)

            // If the filter has filters to exclude, these filters marks as deselected
            let excludedProperties = excludeProperties(property)
            propertiesToDeselect.append(contentsOf: excludedProperties)
        }
        
        return (propertiesToSelect, propertiesToDeselect)
    }
    
    private func excludeProperties(_ filter: Property) -> [Property] {
        guard let propertiesToExclude = filter.excludingProperties, !propertiesToExclude.isEmpty else {
            return []
        }

        var excludedProperties = [Property]()

        for propertiesIdToExclude in propertiesToExclude {
            let propertyToExclude = selectedProperties.first { property in
                property.id == propertiesIdToExclude
            }

            if let propertyToExclude = propertyToExclude {
                let (_, deselected) = toggleProperty(propertyToExclude)
                excludedProperties.append(contentsOf: deselected)
            }
        }

        return excludedProperties
    }
    
    private func getPropertySafely(_ index: Int) -> Property? {
        guard index >= 0 && index < properties.count else {
            return nil
        }

        return properties[index]
    }
}
