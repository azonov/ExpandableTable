//
//  InfoCell.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 08/11/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    // MARK: Private Outlets
    @IBOutlet private var label: UILabel!
    
    // MARK: Private properties
    private var action: (()->())? = nil
    
    // MARK: Public
    func configure(with title: String, action: @escaping ()->()) {
        label.text = title
        self.action = action
    }
    
    // MARK: Private
    @IBAction private func infoButtonTapped() {
        action?()
    }
}
