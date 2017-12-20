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
        let name = "datePicker"
        super.init(style: .default, reuseIdentifier: name)
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[\(name)]-0-|",
            options: [],
            metrics: nil,
            views: [name: datePicker])
        
        let constraintW = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[\(name)]-0-|",
            options: [],
            metrics: nil,
            views: [name: datePicker])

        addConstraints(constraintH + constraintW)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if frame == datePicker.frame {
            datePicker.frame = frame
        }
    }
}
