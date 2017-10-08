//
//  Copyright (c) 2017 Touch Instinct
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

/// Row that simulates spacing, can end editing on click, specify this in constructor
public final class EmptyCellRow: TableRow<EmptyCell> {

    convenience init(with height: CGFloat,
                     color: UIColor = .clear,
                     endEditingOnClick: Bool = false) {

        self.init(item: EmptyCellViewModel(height: height, color: color))

        self.on(.click) { options in
            if endEditingOnClick {
                options.cell?.window?.endEditing(true)
            }
        }
    }

    // Used for set custom height to each cell, not for each cell type
    override var defaultHeight: CGFloat? {
        return item.height
    }

    var anyRow: AnyBaseTableRow {
        return AnyBaseTableRow(tableRow: self)
    }

}
