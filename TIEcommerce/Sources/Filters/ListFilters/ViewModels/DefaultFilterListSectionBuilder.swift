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

import TableKit
import TITableKitUtils
import TIUIElements

open class DefaultFilterListSectionBuilder<CellType: BaseSeparatorCell & ConfigurableCell>: FilterTableSectionBuilder {

    open func makeSection<ViewModel: FilterListPickerConfigurator>(with viewModel: ViewModel) -> TableSection where ViewModel.RowViewModel == CellType.CellData {
        let rows = viewModel.visibleValues.map { item in
            TableRow<CellType>(item: item)
                .on(.select) { [weak viewModel] _ in
                    viewModel?.setSelected(model: item, isSelected: !item.isSelected)
                }
                .on(.deselect) { [weak viewModel] _ in
                    viewModel?.setSelected(model: item, isSelected: false)
                }
        }

        let separatedRows: [SeparatorRowBox] = rows.map { $0.separatorRowBox }
        let separator = SeparatorConfiguration(color: .gray)

        separatedRows.configureSeparators(first: separator,
                                          middle: separator,
                                          last: viewModel.isFinishWithSeparator ? separator : SeparatorConfiguration(color: .clear))

        return .init(rows: separatedRows.rows)
    }
}
