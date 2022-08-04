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

import UIKit

open class DefaultFiltersViewModel: NSObject,
                                    FiltersViewModelProtocol {

    public var filters: [DefaultFilterPropertyValue]
    public var selectedFilters: Set<DefaultFilterPropertyValue> = []
    public var cellsViewModels: [FilterCellViewModelProtocol]

    public init(filters: [DefaultFilterPropertyValue]) {
        self.filters = filters
        self.cellsViewModels = filters.compactMap { $0.convertToViewModel() as? FilterCellViewModelProtocol }
    }

    // MARK: - Public methods

    open func filterDidSelected(atIndexPath indexPath: IndexPath) -> [Change] {
        let (selected, deselected) = toggleFilter(atIndexPath: indexPath)

        let changedFilters = filters
            .enumerated()
            .filter { isFilterChanged($0.element, filters: selected) || isFilterChanged($0.element, filters: deselected) }

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

    public func isFilterChanged(_ filter: DefaultFilterPropertyValue, filters: [DefaultFilterPropertyValue]) -> Bool {
        filters.contains(where: { $0.id == filter.id })
    }
}
