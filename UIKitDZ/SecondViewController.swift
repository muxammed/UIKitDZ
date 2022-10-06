//
//  SecondViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 06.10.2022.
//

import Foundation
import UIKit

/// второй ViewController в котором реализованы изученные UI элементы кнопка назад работает как бы отмена регистрации и стирает данные с UserDefaults 
final class SecondViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var interestsView: UIView!
    @IBOutlet weak var futbolSwitch: UISwitch!
    @IBOutlet weak var booksSwitch: UISwitch!
    @IBOutlet weak var computersSwitch: UISwitch!
    @IBOutlet weak var tvSwitch: UISwitch!
    @IBOutlet weak var swiftSwitch: UISwitch!
    @IBOutlet weak var englishLevelLabel: UILabel!
    @IBOutlet weak var englishLevelSlider: UISlider!
    
    @IBOutlet weak var personalDataView: UIView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var viewsSwitcherSegmentController: UISegmentedControl!
    
    // MARK: - UIViewController(*)
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderTextField.inputView = genderPicker
        
        birthdayDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        lastnameTextField.delegate = self
        
        nameLabel.text = name
        surnameTextField.text = surname
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkSegment()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            UserDefaults.standard.removeObject(forKey: Constants.isRegistered)
        }
    }
    
    // MARK: - Public methods
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        
        if let day = components.day, let month = components.month, let year = components.year {
            birthdayTextField.text = "\(day).\(month).\(year)"
        }
    }
    
    @objc func keyboardShown(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            var heightToForUp = (self.view.frame.height - lastnameTextField.frame.origin.y)
            heightToForUp += lastnameTextField.frame.height
            self.view.frame.origin.y = keyboardHeight - heightToForUp
        }
    }
    
    @objc func keyboardHided(_ notification: Notification) {
        
        view.frame.origin.y = 0
    }
    
    // MARK: - IBAction
    @IBAction func sliderSlidedAction(_ sender: UISlider) {
        
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        switch sender.value {
        case 0:
            englishLevelLabel.text = "Низнаю"
        case 1:
            englishLevelLabel.text = "Средний"
        case 2:
            englishLevelLabel.text = "Хорошо"
        default:
            break
        }
    }
    @IBAction func segmentChangedAction(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        checkSegment()
    }
    @IBAction func saveInterestsAction(_ sender: Any) {
        showAlert(title: "Успех", message: "Данные о интересах сохранены")
    }
    @IBAction func savePersonalDataAction(_ sender: Any) {
        showAlert(title: "Успех", message: "Персональные данные сохранены")
    }
    
    // MARK: - Private Methods
    
    fileprivate func checkSegment() {
        if viewsSwitcherSegmentController.selectedSegmentIndex == 0 {
            
            UIView.animate(withDuration: 0.8) {
                self.personalDataView.alpha = 1
                self.interestsView.alpha = 0
                self.view.layoutIfNeeded()
            }
            
        } else {
            UIView.animate(withDuration: 0.8) {
                self.personalDataView.alpha = 0
                self.interestsView.alpha = 1
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    // MARK: - Constants
    let genders = ["мужской", "женский"]
    var name: String?
    var surname: String?
}

/// расширения для показа Alertа
extension SecondViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

/// UIPickerViewDelegate, UIPickerViewDataSource
extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
    }
}

/// UITextFieldDelegate
extension SecondViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == lastnameTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
