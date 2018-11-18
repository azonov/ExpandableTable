//
//  DatePickerCell.swift
//  AZExpandable
//
//  Created by Andrey Zonov on 20/10/2017.
//

import UIKit

class DatePickerCell: UITableViewCell {
    
    // MARK: Public Properties
    weak var datePicker: UIDatePicker!
    
    // MARK: Lifecycle
    init() {
        let datePicker = UIDatePicker(frame: .zero)
        self.datePicker = datePicker
        
        super.init(style: .default, reuseIdentifier: String(describing: type(of: self)))
        
        addSubview(datePicker)
        datePicker.makeEdgesEqualToSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
