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
    
    private func toggleItem(at indexPath: IndexPath) {
        guard expandedCell?.indexPath != indexPath else {
            expandableTable.unexpandCell()
            expandedCell = nil
            return
        }
        let cellViewModel = tableViewModel.sections[indexPath.section].cells[indexPath.row]
        let cellType: ExpandedCellInfo.CellType
        switch cellViewModel.expandingType {
        case .date:
            cellType = .datePicker { datePicker in
                datePicker.minimumDate = Date()
                //TODO: realize
//                datePicker.addTarget(self, action: #selector(didChangeValue), for: .valueChanged)
            }
            
        case .picker:
            cellType = .picker { picker in
                //TODO: realize
//                picker.dataSource = self
//                picker.delegate = self
            }
            
        case .custom:
            cellType = .custom { [weak self] indexPath -> (UITableViewCell) in
                let centeredCell = self?.tableView.dequeueReusableCell(withIdentifier: "CenteredLabelCell",
                                                                       for: indexPath) as! CenteredLabelCell
                centeredCell.configure(with: "Hint Inside your custom cell")
                centeredCell.backgroundColor = .lightGray
                return centeredCell
            }
        }
        let cell = ExpandedCellInfo(for: indexPath, cellType: cellType)
        expandedCell = cell
        expandableTable.expandCell(cell)
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
            return try CellFactory.cell(for: cellModel, in: tableView, indexPath: indexPath) { [weak self] in
                self?.toggleItem(at: indexPath)
            }
        } catch {
            assertionFailure("handle \(error)")
            return UITableViewCell(style: .default, reuseIdentifier: "default")
        }
    }
}

// MARK: - UITableViewDelegate
extension DemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleItem(at: indexPath)
    }
}
