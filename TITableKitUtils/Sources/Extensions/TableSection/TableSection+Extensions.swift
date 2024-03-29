//
//  Copyright (c) 2020 Touch Instinct
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
import class UIKit.UIView

public extension TableSection {

    /// Initializes section with rows and zero height footer and header.
    ///
    /// - Parameter rows: Rows to insert into section.
    convenience init(onlyRows rows: [Row]) {
        self.init(rows: rows)

        if #available(iOS 15, *) {
            self.headerView = nil
            self.footerView = nil
        } else {
            self.headerView = UIView()
            self.footerView = UIView()
        }

        self.headerHeight = .leastNonzeroMagnitude
        self.footerHeight = .leastNonzeroMagnitude
    }

    /// Initializes an empty section.
    static func emptySection() -> TableSection {
        let tableSection = TableSection()
        
        if #available(iOS 15, *) {
            tableSection.headerView = nil
            tableSection.footerView = nil
        } else {
            tableSection.headerView = UIView()
            tableSection.footerView = UIView()
        }
        
        return tableSection
    }
}
