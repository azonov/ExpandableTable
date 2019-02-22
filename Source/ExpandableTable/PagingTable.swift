//
//  PagingTable.swift
//  AZExpandable
//
//  Created by Andrey Zonov on 18/11/2018.
//

import UIKit

public typealias NextPageClosure = (PagingTable) -> ()

public class PagingTable: NSObject {
    
    public enum PagingError: Error {
        case described(string: String)
    }
    
    // MARK: Private Properties
    private var proxy: ExpandableProxy?
    private var loadMoreIndexPath: IndexPath?
    private weak var tableView: UITableView!
    private weak var infoProvider: TableInfoProvider!
    private var nextPageClosure: NextPageClosure
    
    // MARK: Lifecycle
    public init(tableView: UITableView,
                infoProvider: TableInfoProvider,
                nextPage: @escaping NextPageClosure) {
        self.tableView = tableView
        self.infoProvider = infoProvider
        self.nextPageClosure = nextPage
        super.init()
        proxy = ExpandableProxy(tableDelegate: infoProvider, proxyDelegate: self)
        tableView.dataSource = proxy
        tableView.delegate = proxy
    }
    
    public func addPagingIndicator() throws {
        try makePagingIndicatorVisible(true)
    }
    
    public func removePagingIndicator() throws {
        try makePagingIndicatorVisible(false)
    }
    
    private func makePagingIndicatorVisible(_ isVisible: Bool) throws {
        let sectionsCount = tableView.numberOfSections
        
        guard sectionsCount > 0 else {
            throw PagingError.described(string: "numberOfSections > 0")
        }
        
        let rowsCount = tableView.numberOfRows(inSection: sectionsCount - 1)
        
        guard rowsCount > 0 else {
            throw PagingError.described(string: "rowsCount > 0")
        }
        
        var indexPath = IndexPath(item: rowsCount - 1,
                                  section: sectionsCount - 1)
        loadMoreIndexPath = isVisible ? indexPath : nil
        tableView.beginUpdates()
        if isVisible {
            indexPath.incrementRow()
            tableView?.insertRows(at: [indexPath], with: .top)
        } else {
            tableView?.deleteRows(at: [indexPath], with: .bottom)
        }
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource
extension PagingTable: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = infoProvider.tableView(tableView ,numberOfRowsInSection: section)
        if loadMoreIndexPath?.section == section {
            loadMoreIndexPath?.row = rows
            return rows + 1
        } else {
            return rows
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard loadMoreIndexPath != indexPath else {
            return ActivityIndicatorCell()
        }
        return infoProvider.tableView(tableView, cellForRowAt: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension PagingTable: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard loadMoreIndexPath != indexPath else {
            nextPageClosure(self)
            return
        }
        infoProvider.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard loadMoreIndexPath != indexPath else {
            return UITableView.automaticDimension
        }
        return infoProvider.tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard loadMoreIndexPath != indexPath else {
            return
        }
        infoProvider.tableView?(tableView, didSelectRowAt: indexPath)
    }
}
