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

public extension TableDirector {

    /**
     method replaces current table director's section at index and reloads it
     
     - parameter section: new section
     - parameter index:   current replaced section index
     - parameter reload:  is reloaded after replace

     - returns: self
     */
    @discardableResult
    public func replace(section: TableSection, atIndex index: Int, reload: Bool = true) -> Self {
        if index < sections.count {
            remove(sectionAt: index)
        }
        insert(section: section, atIndex: index)
        if reload {
            self.reload(sectionAtIndex: index)
        }
        return self
    }

    /**
     method reloads section at index with animation
     
     - parameter index:     current reloaded section index
     - parameter animation: reloading animation. Default .none

     - returns: self
     */
    @discardableResult
    public func reload(sectionAtIndex index: Int, with animation: UITableViewRowAnimation = .none) -> Self {
        let action = { [tableView] in
            guard let tableView = tableView else {
                return
            }

            if index < tableView.numberOfSections {
                tableView.reloadSections([index], with: animation)
            } else {
                tableView.reloadData()
            }
        }
        if animation == .none {
            UIView.performWithoutAnimation(action)
        } else {
            action()
        }
        return self
    }

    /**
     method replaces current table director's state with sections
     
     - parameter sections: new sections

     - returns: self
     */
    @discardableResult
    public func replace(withSections sections: [TableSection]) -> Self {
        clear().append(sections: sections).reload()
        return self
    }

    /**
     method replaces current table director's state with section
     
     - parameter section: new section

     - returns: self
     */
    @discardableResult
    public func replace(withSection section: TableSection) -> Self {
        return replace(withSections: [section])
    }

    /**
     method replaces current table director's state with rows
     
     - parameter rows: new rows

     - returns: self
     */
    @discardableResult
    public func replace(withRows rows: [Row]) -> Self {
        return replace(withSection: TableSection(rows: rows))
    }

}

// MARK: - Separator Configuration

public extension TableDirector {

    /// Configure separators for bunch of rows in array
    /// - parameter rows: Rows for configuration
    /// - parameter extreme: Configuration that will be used for extreme values, for first or last row
    /// - parameter middle: Configuration for intermediate rows
    func configure(rows: [AnyBaseTableRow],
                   extreme extremeSeparatorConfiguration: SeparatorConfiguration,
                   middle middleSeparatorConfiguration: SeparatorConfiguration) {

        if rows.isEmpty {
            return
        }

        switch rows.count {
        case 1:
            rows.first?.viewModel.set(separatorType: .full(extremeSeparatorConfiguration, extremeSeparatorConfiguration))
        default:
            rows.forEach { $0.viewModel.set(separatorType: .full(middleSeparatorConfiguration, middleSeparatorConfiguration))}
            rows.first?.viewModel.set(separatorType: .top(extremeSeparatorConfiguration))
            rows.last?.viewModel.set(separatorType: .bottom(extremeSeparatorConfiguration))
        }
    }
}
