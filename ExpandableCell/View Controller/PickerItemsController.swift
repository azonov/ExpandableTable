//
//  PickerItemsController.swift
//  ExpandableCell
//
//  Created by Andrey Zonov on 18/12/2017.
//  Copyright © 2017 Andrey Zonov. All rights reserved.
//

import UIKit

class PickerItemsController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var updateClosure: (String)->()
    
    init(updateClosure: @escaping (String)->()) {
        self.updateClosure = updateClosure
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "row \(row) component \(component)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let title = self.pickerView(pickerView, titleForRow: row, forComponent: component) {
            updateClosure(title)
        }
    }
    
    @objc func datePickerDidChangeValue(_ datePicker: UIDatePicker) {
        let title = DateFormatter.localizedString(from: datePicker.date, dateStyle: .medium, timeStyle: .medium)
        updateClosure(title)
    }
}
