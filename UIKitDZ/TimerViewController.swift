//
//  TimerViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 16.10.2022.
//

import UIKit

final class TimerViewController: UIViewController {
    
    
    @IBOutlet weak var timePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
            label.text = String(row)
            label.textAlignment = .center
            return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let label = pickerView.view(forRow: row, forComponent: component) as? UILabel {

                if component == 0, row > 1 {
                    label.text = String(row) + " hours"
                }
                else if component == 0 {
                    label.text = String(row) + " hour"
                }
                else if component == 1 {
                    label.text = String(row) + " min"
                }
                else if component == 2 {
                    label.text = String(row) + " sec"
                }
            }
    }
}
