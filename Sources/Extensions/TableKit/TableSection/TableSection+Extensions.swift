import TableKit

public extension TableSection {

    /// Initializes section with rows and zero height footer and header.
    ///
    /// - Parameter rows: Rows to insert into section.
    convenience init(onlyRows rows: [Row]) {
        self.init(rows: rows)

        self.headerView = nil
        self.footerView = nil

        self.headerHeight = .leastNonzeroMagnitude
        self.footerHeight = .leastNonzeroMagnitude
    }

}
