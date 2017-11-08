//
//  DemoViewController.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 18/10/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import UIKit
import AZExpandable

class DemoViewController: UIViewController {
    
    // MARK: IBOutlet's
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Private properties
    private var expandableTable: ExpandableTable!
    private var expandedCell: ExpandedCellInfo?
    private var tableViewModel = TableViewModelFactory.staticExpandableTable
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CellFactory.registerCells(for: tableView)
        expandableTable = ExpandableTable(with: tableView, infoProvider: self)
    }
}

// MARK: - UITableViewDataSource
extension DemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = tableViewModel.sections[indexPath.section].cells[indexPath.row]
        do {
            return try CellFactory.cell(for: cellModel, in: tableView, indexPath: indexPath)
        } catch {
            return UITableViewCell(style: .default, reuseIdentifier: "default")
        }
    }
}

// MARK: - UITableViewDelegate
extension DemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard expandedCell?.indexPath != indexPath else {
            expandableTable.unexpandCell()
            expandedCell = nil
            return
        }
        let cellClosure: CellClosure = { (IndexPath) -> (UITableViewCell) in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "q")
            cell.textLabel?.text = "expanded"
            cell.detailTextLabel?.text = "\(indexPath.row)"
            return cell
        }
        //        let cell = ExpandedCellInfo(for: indexPath, cellType: .custom(cellClosure))
        let cell = ExpandedCellInfo(for: indexPath, cellType: .datePicker(nil))
        expandedCell = cell
        expandableTable.expandCell(cell)
    }
}
