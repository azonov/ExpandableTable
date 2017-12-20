//
//  IndexPath+SyntaxSugar.swift
//  Pods
//
//  Created by Andrey Zonov on 20/10/2017.
//

import Foundation

extension IndexPath {
    
    mutating func incrementRow() {
        row += 1
    }
    
    mutating func decrementRow() {
        row -= 1
    }
}
