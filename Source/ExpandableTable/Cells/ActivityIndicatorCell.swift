//
//  ActivityIndicatorCell.swift
//  AZExpandable
//
//  Created by Andrey Zonov on 11/17/18.
//

import UIKit

class ActivityIndicatorCell: UITableViewCell {
    
    // MARK: Public Properties
    lazy var activityIndicator: UIActivityIndicatorView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        let activityIndicator = UIActivityIndicatorView(frame: frame)
        
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = false
        
        return activityIndicator
    }()
    
    // MARK: Lifecycle
    init() {
        super.init(style: .default, reuseIdentifier: String(describing: type(of: self)))
        
        addSubview(activityIndicator)
        activityIndicator.makeEdgesEqualToSuperView()
        activityIndicator.startAnimating()
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        separatorInset = UIEdgeInsets(top: 0, left: CGFloat.infinity, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
