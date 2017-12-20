//
//  PickerCell.swift
//  Pods-ExpandableCell
//
//  Created by Andrey Zonov on 27/10/2017.
//

import UIKit

class PickerCell: UITableViewCell {
    
    // MARK: Public Properties
    weak var picker: UIPickerView!
    
    // MARK: Lifecycle
    init() {
        let picker = UIPickerView(frame: .zero)
        self.picker = picker
        let name = "picker"
        super.init(style: .default, reuseIdentifier: name)
        addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[\(name)]-0-|",
            options: [],
            metrics: nil,
            views: [name: picker])
        
        let constraintW = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[\(name)]-0-|",
            options: [],
            metrics: nil,
            views: [name: picker])
        
        addConstraints(constraintH + constraintW)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if frame == picker.frame {
            picker.frame = frame
        }
    }
}
