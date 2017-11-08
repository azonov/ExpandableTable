//
//  CenteredLabelCell.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 08/11/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import UIKit

class CenteredLabelCell: UITableViewCell {
    
    // MARK: Private Outlets
    @IBOutlet private var label: UILabel!
    
    // MARK: Public
    func configure(with title: String) {
        label.text = title
    }
}
