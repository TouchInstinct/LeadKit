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

open class DefaultFiltersViewModel<RowViewModelType: FilterCellViewModelProtocol & Hashable>: NSObject,
                                                                                               FiltersViewModelProtocol {

    public typealias RowViewModel = RowViewModelType

    private var cellsViewModels: [RowViewModelType]

    public var filters: [DefaultFilterPropertyValue] {
        didSet {
            rebuildCellsViewModels()
            filtersCollection?.updateView()
        }
    }

    public var selectedFilters: Set<DefaultFilterPropertyValue> = [] {
        didSet {
            reselectFilters()
            rebuildCellsViewModels()
            filtersCollection?.updateView()
        }
    }

    public weak var filtersCollection: UpdatableView?

    public init(filters: [DefaultFilterPropertyValue]) {
        self.filters = filters
        self.cellsViewModels = filters.compactMap {
            RowViewModelType(id: $0.id,
                              title: $0.title,
                              appearance: $0.cellAppearance,
                              isSelected: $0.isSelected)
        }
    }

    // MARK: - Open methods

    open func filterDidSelected(atIndexPath indexPath: IndexPath) -> [Change] {
        let (selected, deselected) = toggleFilter(atIndexPath: indexPath)

        let changedFilters = filters
            .enumerated()
            .filter { isFilterInArray($0.element, filters: selected) || isFilterInArray($0.element, filters: deselected) }

        for (offset, element) in changedFilters {
            cellsViewModels[offset].isSelected = selectedFilters.contains(element)
            filters[offset].isSelected = selectedFilters.contains(element)
        }

        let changedItems = changedFilters
            .map {
                Change(indexPath: IndexPath(item: $0.offset, section: .zero),
                       viewModel: cellsViewModels[$0.offset])
            }

        return changedItems
    }

    open func rebuildCellsViewModels() {
        cellsViewModels = filters.compactMap {
            RowViewModelType(id: $0.id,
                              title: $0.title,
                              appearance: $0.cellAppearance,
                              isSelected: $0.isSelected)
        }
    }

    // MARK: - Public methods

    public func getCellsViewModels() -> [FilterCellViewModelProtocol] {
        cellsViewModels
    }

    public func isFilterInArray(_ filter: DefaultFilterPropertyValue, filters: [DefaultFilterPropertyValue]) -> Bool {
        filters.contains(where: { $0.id == filter.id })
    }

    public func reselectFilters() {
        let selectedFilters = Array(selectedFilters)

        filters.enumerated().forEach {
            filters[$0.offset].isSelected = isFilterInArray($0.element, filters: selectedFilters)
        }
    }
}
