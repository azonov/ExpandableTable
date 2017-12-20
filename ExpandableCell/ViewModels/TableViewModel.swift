//
//  TableViewModel.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 27/10/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import Foundation

enum ExpandingType {
    case date
    case picker
    case custom
}

struct TableViewModel {
    
    struct Section {
        
        struct Cell {
            var title: String
            var expandingType: ExpandingType
        }
        let title: String?
        var cells: [Cell]
    }
    
    static var expandable = TableViewModel(sections: [])
    var sections: [Section]
}


extension TableViewModel {
    
    func cell(for indexPath: IndexPath) -> TableViewModel.Section.Cell {
        return sections[indexPath.section].cells[indexPath.row]
    }
    
    mutating func replace(cell: TableViewModel.Section.Cell, at indexPath: IndexPath) {
        sections[indexPath.section].cells[indexPath.row] = cell
    }
}
