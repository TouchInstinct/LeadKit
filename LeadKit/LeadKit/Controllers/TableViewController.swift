//
//  TableViewController.swift
//  LeadKit
//
//  Created by Ivan Smolin on 30/05/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public enum CellCreationType: Int {

    case Preloaded = 0
    case OnTheFlight = 1
    
}

public class TableViewController: UITableViewController, CellsControllerProtocol {

    private var heightCache: [NSIndexPath: CGFloat] = [:]

    private var cellsObjectsCreators: [String: ViewsGenerator<UITableViewCell>] = [:]

    private let cellCreationType: CellCreationType

    // MARK: - Initialization

    public init(style: UITableViewStyle, cellCreationType: CellCreationType = .OnTheFlight) {
        self.cellCreationType = cellCreationType
        super.init(style: style)
    }

    public required init?(coder aDecoder: NSCoder) {
        if let cellCreationType = CellCreationType(rawValue: aDecoder.decodeIntegerForKey("CellCreationType")) {
            self.cellCreationType = cellCreationType
            super.init(coder: aDecoder)
        } else {
            return nil
        }
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        invalidateCache()
    }

    public override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeInteger(cellCreationType.rawValue, forKey: "CellCreationType")
    }

    public func registerCellsGenerator(cellsGenerator: ViewsGenerator<UITableViewCell>,
                                       forCellsWithIdentifier cellIdentifier: String) {
        cellsObjectsCreators[cellIdentifier] = cellsGenerator
    }

    // MARK: - Table view data source

    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        let cellIdentifier = cellIdentifierForIndexPath(indexPath)

        switch cellCreationType {
        case .OnTheFlight:
            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        case .Preloaded:
            guard let cellsGenerator = cellsObjectsCreators[cellIdentifier] else {
                fatalError("You should register view generator for cell with identifier \"\(cellIdentifier)\"")
            }

            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) ?? cellsGenerator.get()
        }

        configureCell(cell, atIndexPath: indexPath)

        return cell
    }

    // MARK: - Table view delegate

    public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let immutableIndex = indexPath.immutableIndexPath

        let cellHeight: CGFloat

        if let cachedheight = heightCache[immutableIndex] {
            cellHeight = cachedheight
        } else {
            cellHeight = heightForCellAtIndexPath(immutableIndex)
            heightCache[immutableIndex] = cellHeight
        }

        return cellHeight
    }

    // MARK: - Cache

    public func invalidateCache() {
        heightCache = [:]
    }

    // MARK: - Cells сontroller stub implementation

    public func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        fatalError("Your should implement cellIdentifierForIndexPath(_:)")
    }

    public func configureCell(cell: UITableViewCell, atIndexPath: NSIndexPath) {
        // intended to be implemented in subclasses
    }

    public func heightForCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        // intended to be implemented in subclasses
        return UITableViewAutomaticDimension
    }

}
