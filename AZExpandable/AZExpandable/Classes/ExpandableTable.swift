//
//  ExpandableTable.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 18/10/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import Foundation

public typealias TableInfoProvider = UITableViewDelegate & UITableViewDataSource
public typealias CellClosure = ((IndexPath) -> (UITableViewCell))

public struct ExpandedCellInfo: Equatable {
    
    public enum CellType {
        case datePicker
        case custom(CellClosure)
    }
    
    public var indexPath: IndexPath
    public var cellType: CellType
    
    
    public init(for indexPath: IndexPath, cellType: CellType) {
        self.indexPath = indexPath
        self.cellType = cellType
    }
    
    public static func ==(lhs: ExpandedCellInfo, rhs: ExpandedCellInfo) -> Bool {
        return lhs.indexPath == rhs.indexPath
    }
    
    func isHigherInSameSection(than hint: ExpandedCellInfo) -> Bool {
        return hint.indexPath.section == indexPath.section
            && hint.indexPath.row > indexPath.row
    }
    
    func computedIndexPath(from indexPath: IndexPath) -> IndexPath {
        var computedIndexPath = indexPath
        if indexPath.section == self.indexPath.section
            && indexPath.row > self.indexPath.row
        {
            computedIndexPath.decrementRow()
        }
        return computedIndexPath
    }
}

public class ExpandableTable: NSObject {
    
    private var proxy: ExpandableProxy?
    private var expandedCell: ExpandedCellInfo?
    private weak var tableView: UITableView!
    private weak var infoProvider: TableInfoProvider!
    
    public init(with tableView: UITableView, infoProvider: TableInfoProvider) {
        self.tableView = tableView
        self.infoProvider = infoProvider
        super.init()
        proxy = ExpandableProxy(tableDelegate: infoProvider, proxyDelegate: self)
        tableView.dataSource = proxy
        tableView.delegate = proxy
    }
    
    public func expandCell(_ cell: ExpandedCellInfo) {
        var resultCell = cell
        resultCell.indexPath.incrementRow()
        
        guard expandedCell != resultCell else { return }
        
        if expandedCell != nil {
            unexpandCell()
        }
        expandedCell = resultCell
        
        tableView?.insertRows(at: [resultCell.indexPath], with: .middle)
    }
    
    public func unexpandCell() {
        guard let indexPath = expandedCell?.indexPath else { return }
        expandedCell = nil
        tableView?.deleteRows(at: [indexPath], with: .middle)
    }
}

extension ExpandableTable: UITableViewDataSource {
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = infoProvider.tableView(tableView ,numberOfRowsInSection: section)
        guard let expandedCell = expandedCell else {
            return rows
        }
        return expandedCell.indexPath.section == section ? rows + 1 : rows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath != expandedCell?.indexPath else {
            switch expandedCell!.cellType {
            case .custom(let cellClosure):
                return cellClosure(indexPath)
                
            default:
                return UITableViewCell()
            }
        }
        let computedIndexPath = expandedCell?.computedIndexPath(from: indexPath) ?? indexPath
        return infoProvider.tableView(tableView, cellForRowAt: computedIndexPath)
    }

}

extension ExpandableTable: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath != expandedCell?.indexPath else {
            return UITableViewAutomaticDimension
        }
        let computedIndexPath = expandedCell?.computedIndexPath(from: indexPath) ?? indexPath
        return infoProvider.tableView?(tableView, heightForRowAt: computedIndexPath) ?? UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath != expandedCell?.indexPath {
            let computedIndexPath = expandedCell?.computedIndexPath(from: indexPath) ?? indexPath
            infoProvider.tableView?(tableView, didSelectRowAt: computedIndexPath)
        }
    }
}

extension IndexPath {
    
    fileprivate mutating func incrementRow() {
        row += 1
    }
    
    fileprivate mutating func decrementRow() {
        row -= 1
    }
}
