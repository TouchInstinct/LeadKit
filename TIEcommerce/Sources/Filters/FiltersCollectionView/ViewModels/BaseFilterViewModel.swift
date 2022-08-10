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

import TIUIKitCore
import UIKit

open class BaseFilterViewModel<CellViewModelType: FilterCellViewModelProtocol & Hashable,
                               PropertyValue: FilterPropertyValueRepresenter & Hashable>: FilterViewModelProtocol {

    // MARK: - FilterViewModelProtocol

    public typealias Property = PropertyValue
    public typealias CellViewModelType = CellViewModelType

    public var properties: [PropertyValue] = [] {
        didSet {
            filtersCollection?.update()
        }
    }
    public var selectedProperties: [PropertyValue] = [] {
        didSet {
            filtersCollection?.update()
        }
    }

    public weak var filtersCollection: UpdatableView?

    public private(set) var cellsViewModels: [CellViewModelType]

    public init(filters: [PropertyValue], cellsViewModels: [CellViewModelType] = []) {
        self.properties = filters
        self.cellsViewModels = cellsViewModels
    }

    open func filterDidSelected(atIndexPath indexPath: IndexPath) -> [Change] {
        let (selected, deselected) = toggleProperty(atIndexPath: indexPath)

        let changedProperties = properties
            .enumerated()
            .filter { selected.contains($0.element) || deselected.contains($0.element) }

        changedProperties.forEach { index, element in
            let isSelected = selectedProperties.contains(element)

            setSelectedCell(atIndex: index, isSelected: isSelected)
            setSelectedProperty(atIndex: index, isSelected: isSelected)
        }

        let changedItems = changedProperties
            .map {
                Change(indexPath: IndexPath(item: $0.offset, section: .zero),
                       viewModel: cellsViewModels[$0.offset])
            }

        return changedItems
    }

    open func setSelectedCell(atIndex index: Int, isSelected: Bool) {
        cellsViewModels[index].isSelected = isSelected
    }

    open func setSelectedProperty(atIndex index: Int, isSelected: Bool) {
        properties[index].isSelected = isSelected
    }

    open func isPropertyInArray(_ property: PropertyValue, properties: [PropertyValue]) -> Bool {
        properties.contains(where: { $0.id == property.id })
    }
}
