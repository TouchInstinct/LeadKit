//
//  TableViewController.swift
//  LeadKit
//
//  Created by Ivan Smolin on 30/05/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public class TableViewController: UITableViewController, CellsControllerProtocol {

    private var cellsObjectsCreators: [String: ViewsGenerator<UITableViewCell>] = [:]

    private let cellCreationType: CellCreationType

    private static let creationTypeKey = "CellCreationType"

    // MARK: - Initialization

    public init(style: UITableViewStyle, cellCreationType: CellCreationType = .OnTheFlight) {
        self.cellCreationType = cellCreationType
        super.init(style: style)
    }

    public required init?(coder aDecoder: NSCoder) {
        if let creationType = CellCreationType(rawValue: aDecoder.decodeIntegerForKey(TableViewController.creationTypeKey)) {
            self.cellCreationType = creationType
            super.init(coder: aDecoder)
        } else {
            return nil
        }
    }

    public override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeInteger(cellCreationType.rawValue, forKey: TableViewController.creationTypeKey)
    }

    /**
     method which adds cells generator for cells with specified reuse identifier

     - parameter cellsGenerator: cells generator
     - parameter cellIdentifier: cell reuse identifier
     */
    public func registerCellsGenerator(cellsGenerator: ViewsGenerator<UITableViewCell>,
                                       forCellsWithIdentifier cellIdentifier: String) {
        cellsObjectsCreators[cellIdentifier] = cellsGenerator
    }

    // MARK: - UITableViewDataSource

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

    // MARK: - Cells сontroller stub implementation

    /**
     method which returns reuse identifier for cell at specified index path

     - parameter indexPath: NSIndexPath object

     - returns: reuse identifier
     */
    public func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        fatalError("Your should implement cellIdentifierForIndexPath(_:)")
    }

    /**
     method which configures cell before it can be used

     - parameter cell:        UITableView or subclass cell
     - parameter atIndexPath: index path of cell
     */
    public func configureCell(cell: UITableViewCell, atIndexPath: NSIndexPath) {
        // intended to be implemented in subclasses
    }

    /**
     method which return height for cell at specified index path

     - parameter indexPath: NSIndexPath object

     - returns: height of cell at specified index path
     */
    public func heightForCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        // intended to be implemented in subclasses
        return UITableViewAutomaticDimension
    }

}
