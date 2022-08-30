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

import TISwiftUtils
import UIKit

open class BaseFilterViewModel<CellViewModelType: FilterCellViewModelProtocol & Hashable,
                               PropertyValue: FilterPropertyValueRepresenter & Hashable>: FilterViewModelProtocol {

    // MARK: - FilterViewModelProtocol

    public typealias Change = (indexPath: IndexPath, viewModel: CellViewModelType)

    public var values: [PropertyValue] = [] {
        didSet {
            filtersCollection?.update()
        }
    }
    public var selectedValues: [PropertyValue] = [] {
        didSet {
            filtersCollection?.update()
        }
    }

    public weak var filtersCollection: Updatable?

    public private(set) var cellsViewModels: [CellViewModelType]

    public init(filterPropertyValues: [PropertyValue], cellsViewModels: [CellViewModelType] = []) {
        self.values = filterPropertyValues
        self.cellsViewModels = cellsViewModels
    }

    open func filterDidSelected(atIndexPath indexPath: IndexPath) -> [Change] {
        let (selected, deselected) = toggleProperty(atIndexPath: indexPath)

        let changedValues = values
            .enumerated()
            .filter { selected.contains($0.element) || deselected.contains($0.element) }

        changedValues.forEach { index, element in
            let isSelected = selectedValues.contains(element)

            setSelectedCell(atIndex: index, isSelected: isSelected)
            setSelectedProperty(atIndex: index, isSelected: isSelected)
        }

        let changedItems = changedValues
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
        values[index].isSelected = isSelected
    }
}
