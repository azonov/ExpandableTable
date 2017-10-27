//
//  ExpandableCellInfo.swift
//  Pods
//
//  Created by Andrey Zonov on 20/10/2017.
//

import Foundation

public typealias CellClosure = ((IndexPath) -> (UITableViewCell))
public typealias DatePickerSetupClosure = ((UIDatePicker) -> ())
public typealias PickerSetupClosure = ((UIPickerView) -> ())

public struct ExpandedCellInfo: Equatable {
    
    public enum CellType {
        case datePicker(DatePickerSetupClosure?)
        case picker(PickerSetupClosure)
        case custom(CellClosure)
    }
    
    public var indexPath: IndexPath
    public var cellType: CellType
    
    
    public init(for indexPath: IndexPath, cellType: CellType) {
        self.indexPath = indexPath
        self.cellType = cellType
    }
    
    public static func ==(lhs: ExpandedCellInfo, rhs: ExpandedCellInfo) -> Bool {
        return lhs.indexPath == rhs.indexPath
    }
    
    func isHigherInSameSection(than hint: ExpandedCellInfo) -> Bool {
        return hint.indexPath.section == indexPath.section
            && hint.indexPath.row > indexPath.row
    }
    
    func computedIndexPath(from indexPath: IndexPath) -> IndexPath {
        var computedIndexPath = indexPath
        if indexPath.section == self.indexPath.section
            && indexPath.row > self.indexPath.row {
            computedIndexPath.decrementRow()
        }
        return computedIndexPath
    }
}
