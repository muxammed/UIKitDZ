//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// это повторение урока 13 кода по видео
class LessonViewController: UIViewController, UITextFieldDelegate {
    
    var myTextField = UITextField()

    fileprivate func configure() {
        self.view.backgroundColor = .white
        let textFieldFrame = CGRect(x: 0, y: 0, width: 200, height: 31)
        myTextField = UITextField(frame: textFieldFrame)
        myTextField.borderStyle = .roundedRect
        myTextField.contentVerticalAlignment = .center
        myTextField.textAlignment = .center
        myTextField.placeholder = "I swift developer"
        myTextField.center = view.center
        view.addSubview(myTextField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        myTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(ncParam:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil, queue: nil) { _ in
            self.view.frame.origin.y = -200.0
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil,
                                               queue: nil) { _ in
            self.view.frame.origin.y = 0.0
        }
    }
    
    // MARK: - Notification
    @objc func textFieldTextDidChange(ncParam: NSNotification) {
        print("UITextFieldTextDidChange = \(ncParam)")
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("""
textFieldShouldBeginEditing = это я решаю
              можно ли редактировать если вернуть false пользователь не сможет редактировать
""")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing = внимание началось редактирование")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing = внимание закончилось редактирование")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("textFieldShouldEndEditing = внимание закончилось редактирование")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        print("shouldChangeCharactersIn = вы ввели \(string)")
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear = ты что то очистил")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn = хотите убрать клавиатуру")
        if textField == myTextField {
            self.myTextField.resignFirstResponder()
            // self.myTextField.becomeFirstResponder()
        }
        return true
    }
    
}
