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
    private static let cellIdentifier = "CenteredLabelCell"
    
    // MARK: Public
    
    enum CellFactoryError: Error {
        case unsupportedType
        case wrongIdentifier
    }
    
    // MARK: Public
    static func cell(for cellModel: TableViewModel.Section.Cell,
                     in tableView: UITableView,
                     indexPath: IndexPath,
                     cellAction: @escaping (() -> ())) throws -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? CenteredLabelCell
            else { throw CellFactoryError.wrongIdentifier }
        
        cell.configure(with: cellModel.title)
        
        return cell
    }
    
    static func registerCells(for tableView: UITableView) {
        let cellIdentifiers = [cellIdentifier]
        for cellIdentifier in cellIdentifiers {
            let nib = UINib(nibName: cellIdentifier, bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }
}
