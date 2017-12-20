//
//  BasicDemoViewController.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 19/12/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import Foundation
import AZExpandable

class BasicDemoViewController: UIViewController {
    
    // MARK: IBOutlet's
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Private Properties
    private var expandableTable: ExpandableTable!
    private var expandedCell: ExpandedCellInfo?
    
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
        
        // Construct your cell here
        let cellType: ExpandedCellInfo.CellType = .custom { [weak self] indexPath -> (UITableViewCell) in
            let centeredCell = self?.tableView.dequeueReusableCell(withIdentifier: "CenteredLabelCell",
                                                                   for: indexPath) as! CenteredLabelCell
            centeredCell.configure(with: "Hint Inside your custom cell")
            centeredCell.backgroundColor = .lightGray
            return centeredCell
        }
        let cell = ExpandedCellInfo(for: indexPath, cellType: cellType)
        expandedCell = cell
        expandableTable.expandCell(cell)
    }
}

// MARK: - UITableViewDataSource
extension BasicDemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenteredLabelCell", for: indexPath) as! CenteredLabelCell
        cell.configure(with: "Tap to reveal hint for \(indexPath.row) row")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BasicDemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleItem(at: indexPath)
    }
}
