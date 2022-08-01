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
    
    var filters: [Filter] { get set }
    var selectedFilters: Set<Filter> { get set }
    
    var filtersCollectionHolder: FiltersCollectionHolder? { get set }
    
    func filterItem(atIndexPath indexPath: IndexPath)
}

public extension FiltersViewModelProtocol {
    
    func filterItem(atIndexPath indexPath: IndexPath) {
        guard let item = getItemSafely(indexPath.item) else { return }
        
        let (s, d) = filterItem(item)
        filtersCollectionHolder?.select(s)
        filtersCollectionHolder?.deselect(d)
        filtersCollectionHolder?.updateView()
    }
    
    @discardableResult
    private func filterItem(_ item: Filter) -> (selected: [Filter], deselected: [Filter]) {
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
            
            if let itemsToExclude =  item.excludingProperties, !itemsToExclude.isEmpty {
                for itemIdToExclude in itemsToExclude {
                    let itemToExclude = selectedFilters.first { item in
                        item.id == itemIdToExclude
                    }
                    
                    if let itemToExclude = itemToExclude {
                        let (_, deselected) = filterItem(itemToExclude)
                        itemsToDeselect.append(contentsOf: deselected)
                    }
                }
            }
        }
        
        return (itemsToSelect, itemsToDeselect)
    }
    
    private func getItemSafely(_ index: Int) -> Filter? {
        guard index >= 0 && index <= filters.count else {
            return nil
        }
        
        return filters[index]
    }
}
