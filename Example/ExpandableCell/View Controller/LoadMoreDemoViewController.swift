//
//  LoadMoreDemoViewController.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 11/17/18.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import Foundation
import AZExpandable

class LoadMoreDemoViewController: UIViewController {
    
    // MARK: IBOutlet's
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Private Properties
    private var pagingTable: PagingTable!
    private var rowsCount = 20
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CellFactory.registerCells(for: tableView)
        pagingTable = PagingTable(tableView: tableView, infoProvider: self)
        { [weak self] paging in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self?.rowsCount += 20
                self?.tableView.reloadData()
            })
        }
    }
    
    @IBAction func paginationValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            try? pagingTable.addPagingIndicator()
        } else {
            try? pagingTable.removePagingIndicator()
        }
    }
}

// MARK: - UITableViewDataSource
extension LoadMoreDemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenteredLabelCell", for: indexPath) as! CenteredLabelCell
        cell.configure(with: "\(indexPath.row) row")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LoadMoreDemoViewController: UITableViewDelegate {}
