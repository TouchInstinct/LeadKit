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

public protocol FiltersViewModelProtocol: AnyObject {

    associatedtype Filter: FilterPropertyValueRepresenter, Hashable
    associatedtype CellViewModel: FilterCellViewModelProtocol & Hashable

    typealias Change = (indexPath: IndexPath, viewModel: CellViewModel)

    var filters: [Filter] { get set }
    var selectedFilters: Set<Filter> { get set }

    func filterDidSelected(atIndexPath indexPath: IndexPath) -> [Change]
    func toggleFilter(atIndexPath indexPath: IndexPath) -> (selected: [Filter], deselected: [Filter])
}

public extension FiltersViewModelProtocol {

    func toggleFilter(atIndexPath indexPath: IndexPath) -> (selected: [Filter], deselected: [Filter]) {
        guard let item = getFilterSafely(indexPath.item) else { return ([], []) }

        return toggleFilter(item)
    }

    @discardableResult
    private func toggleFilter(_ filter: Filter) -> (selected: [Filter], deselected: [Filter]) {
        var filtersToDeselect = [Filter]()
        var filtersToSelect = [Filter]()
        let selectedFilter = selectedFilters.first { selectedFilter in
            selectedFilter.id == filter.id
        }

        if let selectedFilter = selectedFilter {
            // Removes previously selected filter
            selectedFilters.remove(selectedFilter)
            filtersToDeselect.append(filter)
        } else {
            // Selectes unselected filter
            selectedFilters.insert(filter)
            filtersToSelect.append(filter)

            // If the filter has filters to exclude, these filters marks as deselected
            let excludedFilters = excludeFilters(filter)
            filtersToDeselect.append(contentsOf: excludedFilters)
        }
        
        return (filtersToSelect, filtersToDeselect)
    }
    
    private func excludeFilters(_ filter: Filter) -> [Filter] {
        guard let filtersToExclude = filter.excludingProperties, !filtersToExclude.isEmpty else {
            return []
        }

        var excludedFilters = [Filter]()

        for filtersIdToExclude in filtersToExclude {
            let filterToExclude = selectedFilters.first { filter in
                filter.id == filtersIdToExclude
            }

            if let itemToExclude = filterToExclude {
                let (_, deselected) = toggleFilter(itemToExclude)
                excludedFilters.append(contentsOf: deselected)
            }
        }

        return excludedFilters
    }
    
    private func getFilterSafely(_ index: Int) -> Filter? {
        guard index >= 0 && index < filters.count else {
            return nil
        }

        return filters[index]
    }
}
