//
//  TimerViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 16.10.2022.
//

import UIKit

/// TimerViewController экран с таймером
final class TimerViewController: UIViewController {
    
    // MARK: - Visual components
    @IBOutlet weak var timePicker: UIPickerView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configure()
    }
    
    // MARK: - Private methods
    private func configure() {
        view.layoutSubviews()
        timePicker.selectRow(0, inComponent: 0, animated: true)
        timePicker.selectRow(0, inComponent: 1, animated: true)
        timePicker.selectRow(0, inComponent: 2, animated: true)
        pickerView(timePicker, didSelectRow: 0, inComponent: 0)
        pickerView(timePicker, didSelectRow: 0, inComponent: 1)
        pickerView(timePicker, didSelectRow: 0, inComponent: 2)
    }
    
}

/// UIPickerViewDelegate, UIPickerViewDataSource
extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        case 2:
            return 60
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        let attr = [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "\(row)", attributes: attr)
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let label = pickerView.view(forRow: row, forComponent: component) as? UILabel {

                if component == 0, row > 1 {
                    label.text = String(row) + " ч"
                } else if component == 0 {
                    label.text = String(row) + " ч"
                } else if component == 1 {
                    label.text = String(row) + " мин"
                } else if component == 2 {
                    label.text = String(row) + " с"
                }
            }
    }
}
