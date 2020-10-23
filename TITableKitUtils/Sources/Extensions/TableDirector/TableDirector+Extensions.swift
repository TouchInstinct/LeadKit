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
import UIKit.UITableView

public extension TableDirector {

    /**
     method replaces current table director's section at index and reloads it
     
     - parameter section: new section
     - parameter index:   current replaced section index
     - parameter reload:  is reloaded after replace

     - returns: self
     */
    @discardableResult
    func replace(section: TableSection, atIndex index: Int, reload: Bool = true) -> Self {
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
    func reload(sectionAtIndex index: Int, with animation: UITableView.RowAnimation = .none) -> Self {
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
    func replace(withSections sections: [TableSection]) -> Self {
        clear().append(sections: sections).reload()
        return self
    }

    /**
     method replaces current table director's state with section
     
     - parameter section: new section

     - returns: self
     */
    @discardableResult
    func replace(withSection section: TableSection) -> Self {
        return replace(withSections: [section])
    }

    /**
     method replaces current table director's state with rows
     
     - parameter rows: new rows

     - returns: self
     */
    @discardableResult
    func replace(withRows rows: [Row]) -> Self {
        return replace(withSection: TableSection(rows: rows))
    }

    /// Clear table view and reload it within empty section
    func safeClear() {
        clear().append(section: TableSection(onlyRows: [])).reload()
    }

    /// Inserts rows into table without complete reload.
    ///
    /// - Parameters:
    ///   - rows: Rows to insert.
    ///   - indexPath: Position of first row.
    ///   - animation: The type of animation when rows are inserted
    ///   - manualBeginEndUpdates: Don't call beginUpdates() & endUpdates() inside.
    func insert(rows: [Row],
                at indexPath: IndexPath,
                with animation: UITableView.RowAnimation,
                manualBeginEndUpdates: Bool = false) {

        sections[indexPath.section].insert(rows: rows, at: indexPath.row)
        let indexPaths: [IndexPath] = rows.indices.map {
            IndexPath(row: indexPath.row + $0, section: indexPath.section)
        }

        if manualBeginEndUpdates {
            tableView?.insertRows(at: indexPaths, with: animation)
        } else {
            tableView?.beginUpdates()
            tableView?.insertRows(at: indexPaths, with: animation)
            tableView?.endUpdates()
        }
    }

    /// Removes rows from table without complete reload.
    ///
    /// - Parameters:
    ///   - rowsCount: Number of rows to remove.
    ///   - indexPath: Position of first row to remove.
    ///   - animation: The type of animation when rows are deleted
    ///   - manualBeginEndUpdates: Don't call beginUpdates() & endUpdates() inside.
    func remove(rowsCount: Int,
                startingAt indexPath: IndexPath,
                with animation: UITableView.RowAnimation,
                manualBeginEndUpdates: Bool = false) {

        var indexPaths = [IndexPath]()
        for index in indexPath.row ..< indexPath.row + rowsCount {
            indexPaths.append(IndexPath(row: index, section: indexPath.section))
        }

        indexPaths.reversed().forEach {
            sections[$0.section].remove(rowAt: $0.row)
        }

        if manualBeginEndUpdates {
            tableView?.deleteRows(at: indexPaths, with: animation)
        } else {
            tableView?.beginUpdates()
            tableView?.deleteRows(at: indexPaths, with: animation)
            tableView?.endUpdates()
        }
    }

    /// Method inserts section with animation.
    ///
    /// - Parameters:
    ///   - section: Section to insert
    ///   - index: Position to insert
    ///   - animation: The type of insert animation
    ///   - manualBeginEndUpdates: Don't call beginUpdates() & endUpdates() inside.
    /// - Returns: self
    @discardableResult
    func insert(section: TableSection,
                at index: Int,
                with animation: UITableView.RowAnimation,
                manualBeginEndUpdates: Bool = false) -> Self {

        insert(section: section, atIndex: index)
        if manualBeginEndUpdates {
            tableView?.insertSections([index], with: animation)
        } else {
            tableView?.beginUpdates()
            tableView?.insertSections([index], with: animation)
            tableView?.endUpdates()
        }

        return self
    }

    /// Method removes section with animation.
    ///
    /// - Parameters:
    ///   - index: Position to remove
    ///   - animation: The type of remove animation
    ///   - manualBeginEndUpdates: Don't call beginUpdates() & endUpdates() inside.
    /// - Returns: self
    @discardableResult
    func remove(at index: Int,
                with animation: UITableView.RowAnimation,
                manualBeginEndUpdates: Bool = false) -> Self {

        delete(sectionAt: index)
        if manualBeginEndUpdates {
            tableView?.deleteSections([index], with: animation)
        } else {
            tableView?.beginUpdates()
            tableView?.deleteSections([index], with: animation)
            tableView?.endUpdates()
        }

        return self
    }

    /// Method replace section with animation.
    ///
    /// - Parameters:
    ///   - section: Section to replace
    ///   - index: Position to replace
    ///   - animation: The type of replace animation
    ///   - manualBeginEndUpdates: Don't call beginUpdates() & endUpdates() inside.
    /// - Returns: self
    @discardableResult
    func replace(with section: TableSection,
                 at index: Int,
                 with animation: UITableView.RowAnimation,
                 manualBeginEndUpdates: Bool = false) -> Self {

        remove(at: index, with: animation, manualBeginEndUpdates: manualBeginEndUpdates)
        return insert(section: section, at: index, with: animation, manualBeginEndUpdates: manualBeginEndUpdates)
    }
}
