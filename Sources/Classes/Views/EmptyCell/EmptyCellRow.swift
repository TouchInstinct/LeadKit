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

/// Class that
/// - Simulates spacing with no-breaking constraints
/// - Can end editing on click
public final class EmptyCellRow: TableRow<EmptyCell> {

    private let rowHeight: CGFloat

    /// Provide height with color to create row
    /// - parameter height: Height of row
    /// - parameter color: Color of row
    /// - parameter endEditingOnClick: Will cell end editing for neighbour currently active UIControl subclasses
    /// - returns: Fully configured EmptyCellRow
    public init(height: CGFloat, endEditingOnClick: Bool = false) {
        rowHeight = height

        super.init(item: ())

        if endEditingOnClick {
            self.on(.click) { options in
                options.cell?.window?.endEditing(true)
            }
        }
    }

    /// Used for set custom height to each cell, not for each cell type
    override public var defaultHeight: CGFloat? {
        return rowHeight
    }

}
