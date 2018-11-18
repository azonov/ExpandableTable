//
//  UIView+Autolayout.swift
//  AZExpandable
//
//  Created by Andrey Zonov on 11/16/18.
//

import UIKit

extension UIView {
    
    func makeEdgesEqualToSuperView() {
        guard let superView = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            leftAnchor.constraint(equalTo: superView.leftAnchor),
            rightAnchor.constraint(equalTo: superView.rightAnchor)])
    }
}
