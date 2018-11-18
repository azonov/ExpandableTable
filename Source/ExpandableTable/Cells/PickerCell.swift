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
        
        super.init(style: .default, reuseIdentifier: String(describing: type(of: self)))
        
        addSubview(picker)
        picker.makeEdgesEqualToSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
