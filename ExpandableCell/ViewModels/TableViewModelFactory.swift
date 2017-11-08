//
//  TableViewModelFactory.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 08/11/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import Foundation

struct TableViewModelFactory {
    
    static var staticExpandableTable: TableViewModel {
        let helpCell = TableViewModel.Section.Cell(title: "Help", expandingType: .custom)
        let dateCell = TableViewModel.Section.Cell(title: "Date", expandingType: .date)
        let pickerCell = TableViewModel.Section.Cell(title: "Picker", expandingType: .picker)
        
        let section = TableViewModel.Section(cells: [helpCell, dateCell, pickerCell])
        
        return TableViewModel(sections: [section])
    }
}
