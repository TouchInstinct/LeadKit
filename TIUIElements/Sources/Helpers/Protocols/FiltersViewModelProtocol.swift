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

public protocol FiltersCollectionHolder: AnyObject {
    func select(_ items: [FilterPropertyValueRepresenter])
    func deselect(_ items: [FilterPropertyValueRepresenter])
    func updateView()
}

public protocol FiltersViewModelProtocol: AnyObject {

    associatedtype Filter: FilterPropertyValueRepresenter, Hashable

    var filters: [Filter] { get set }
    var selectedFilters: Set<Filter> { get set }

    var filtersCollectionHolder: FiltersCollectionHolder? { get set }

    func filterItem(atIndexPath indexPath: IndexPath)
}

public extension FiltersViewModelProtocol {

    /// Method of filtering items
    /// - Algorithm:
    ///     1. Determine if current item is selected;
    ///     2. If it was selected:
    ///         - Remove the item from the array of selected items;
    ///     3. if it wasn't selected:
    ///         - Insert the item in the array of selected items;
    ///         - Run excluding filtering (remove every item that should be excluded from list of selected items).
    ///     4. Notify the collection of filters about updating of the item at indexPath
    func filterItem(atIndexPath indexPath: IndexPath) {
        guard let item = getItemSafely(indexPath.item) else { return }

        filterItem(item)
        filtersCollectionHolder?.updateView()
    }

    private func filterItem(_ item: Filter) {
        var itemsToDeselect = [Filter]()
        var itemsToSelect = [Filter]()
        let selectedItem = selectedFilters.first { selectedItem in
            selectedItem.id == item.id
        }

        if let selectedItem = selectedItem {
            selectedFilters.remove(selectedItem)

            itemsToDeselect.append(item)
        } else {
            selectedFilters.insert(item)
            itemsToSelect.append(item)
            itemsToDeselect.append(contentsOf: exclude(withItem: item))

            if let itemsToExclude =  item.excludingProperties, !itemsToExclude.isEmpty {
                for itemIdToExclude in itemsToExclude {
                    let itemToExclude = selectedFilters.first { item in
                        item.id == itemIdToExclude
                    }

                    if let itemToExclude = itemToExclude {
                        filterItem(itemToExclude)
                    }
                }
            }
        }

        itemsToSelect.forEach { item in
            if let index = filters.firstIndex(of: item) {
                filters[index].isSelected = true
            }
        }

        itemsToDeselect.forEach { item in
            if let index = filters.firstIndex(of: item) {
                filters[index].isSelected = false
            }
        }
//        filtersCollectionHolder?.select(itemsToSelect)
//        filtersCollectionHolder?.deselect(itemsToDeselect)
    }

    private func getItemSafely(_ index: Int) -> Filter? {
        guard index >= 0 && index <= filters.count else {
            return nil
        }

        return filters[index]
    }

    private func exclude(withItem item: Filter) -> [Filter] {
        guard let itemsToExclude =  item.excludingProperties, !itemsToExclude.isEmpty else {
            return []
        }

        var deselectedItems = [Filter]()

        for itemIdToExclude in itemsToExclude {
            let itemToExclude = selectedFilters.first { item in
                item.id == itemIdToExclude
            }

            if let itemToExclude = itemToExclude {
                selectedFilters.remove(itemToExclude)
                deselectedItems.append(itemToExclude)
            }
        }

        return deselectedItems
    }
}
