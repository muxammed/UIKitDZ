//
//  LessonViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 26.09.2022.
//

import UIKit
/// Код из видео урока UIKit Урок 5. как пункт ДЗ
class LessonViewController: UIViewController {
    
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.center = view.center
        datePicker.center = view.center
//        datePicker.datePickerMode = .date
        datePicker.datePickerMode = .countDownTimer
        
        var oneYearTime = TimeInterval()
        oneYearTime = 365 * 24 * 60 * 60
        
        let todayDate = Date()
        let oneYearFromToday = todayDate.addingTimeInterval(oneYearTime)
        let twoYearFromDate = todayDate.addingTimeInterval(2 * oneYearTime)
        
        datePicker.minimumDate = oneYearFromToday
        datePicker.maximumDate = twoYearFromDate
        
        // подписаться на протоколы
        picker.dataSource = self
        picker.delegate = self
        view.addSubview(picker)
        datePicker.addTarget(self, action: #selector(datePickerChange(paramdatePicker:)), for: .valueChanged)
        
        datePicker.countDownDuration = 2 * 60
    }
    
    @objc func datePickerChange(paramdatePicker: UIDatePicker) {
        if paramdatePicker.isEqual(self.picker) {
            print("dateChaged: \(paramdatePicker.date)")
        }
    }
}

extension LessonViewController: UIPickerViewDataSource {
    
    // Сколько компонентов выводить
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Сколько строк в компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

extension LessonViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = "row \(row)"
        return result
    }
}
