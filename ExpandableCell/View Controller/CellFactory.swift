//
//  CellFactory.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 08/11/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import UIKit

struct CellFactory {
    
    // MARK: Private
    private static var cells: [ExpandingType: String] = [
        ExpandingType.custom : "InfoCell",
        ExpandingType.date  : "CenteredLabelCell",
        ExpandingType.picker : "CenteredLabelCell",
    ]
    
    // MARK: Public
    
    enum CellFactoryError: Error {
        case unsupportedType
        case wrongIdentifier
    }
    
    // MARK: Public
    static func cell(for cellModel: TableViewModel.Section.Cell,
                     in tableView: UITableView,
                     indexPath: IndexPath) throws -> UITableViewCell
    {
        guard let cellType = cellModel.expandingType,
            let identifier = cells[cellType] else {
                throw CellFactoryError.unsupportedType
        }
        switch cellType {
        case .custom:
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                               for: indexPath) as? InfoCell else {
                                                                throw CellFactoryError.wrongIdentifier
            }
            infoCell.configure(with: cellModel.title) {
                
            }
            return infoCell
            
        case .date, .picker:
            guard let centeredCell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                               for: indexPath) as? CenteredLabelCell else {
                                                                throw CellFactoryError.wrongIdentifier
            }
            centeredCell.configure(with: cellModel.title)
            return centeredCell
        }
    }
    
    static func registerCells(for tableView: UITableView) {
        let cellIdentifiers = cells.values
        for cellIdentifier in cellIdentifiers {
            let nib = UINib(nibName: cellIdentifier, bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }
}
