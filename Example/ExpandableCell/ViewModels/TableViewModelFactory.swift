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
        
        let helpCell1 = TableViewModel.Section.Cell(title: "Tap to reveal help1", expandingType: .custom)
        let helpCell2 = TableViewModel.Section.Cell(title: "Tap to reveal help2", expandingType: .custom)
        let helpCell3 = TableViewModel.Section.Cell(title: "Tap to reveal help3", expandingType: .custom)
        
        let dateCell1 = TableViewModel.Section.Cell(title: "Date 1", expandingType: .date)
        let dateCell2 = TableViewModel.Section.Cell(title: "Date 2", expandingType: .date)
        let dateCell3 = TableViewModel.Section.Cell(title: "Date 3", expandingType: .date)
        
        let pickerCell1 = TableViewModel.Section.Cell(title: "Picker 1", expandingType: .picker)
        let pickerCell2 = TableViewModel.Section.Cell(title: "Picker 2", expandingType: .picker)
        let pickerCell3 = TableViewModel.Section.Cell(title: "Picker 3", expandingType: .picker)
        
        let sectionHelp = TableViewModel.Section(title: "Help cells section", cells: [helpCell1, helpCell2, helpCell3])
        let sectionDate = TableViewModel.Section(title: "Date cells section", cells: [dateCell1, dateCell2, dateCell3])
        let sectionPicker = TableViewModel.Section(title: "Picker cells section", cells: [pickerCell1, pickerCell2, pickerCell3])
        
        return TableViewModel(sections: [sectionHelp, sectionDate, sectionPicker])
    }
}
