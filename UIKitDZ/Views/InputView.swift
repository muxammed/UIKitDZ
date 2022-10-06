//
//  InputView.swift
//  UIKitDZ
//
//  Created by muxammed on 24.09.2022.
//

import UIKit

/// кастомный InputView что бы переиспользовать включает в себя настраиваемые по цвету и подскажке UILabel, UITextField, также есть возможность определить UITextField как поле ввода пароля
/// - Parameters
///  - hintText: Текст для UILabel  сверху UITextField
///  - hintColor: Цвет для UILabel  сверху UITextField
///  - inputTextFieldPlaceholder: Текст подсказка для UITextField
///  - inputTextFieldTintColor: Цвет подсказки UITextField
///  - isPasswordTextField: Переключатель в случаи истина UITextField станет password и появится кнопка для вскрытия/сокрытия пароля
///  - pickerView: экзепляр UIPickerView для назначение его inputView'ом внутреннего UITextField'a
///  - textFieldTag: Int число прописывается как tag UITextField для разделения в методах прокола UITextFieldDelegate, UITextFieldDataSource
final class InputView: UIView {
    var hintColor: UIColor? {
        get {
            return self.hintColor
        }
        set {
            hintLabel.textColor = newValue
        }
    }
    
    var hintText: String? {
        get {
            return self.hintText
        }
        set {
            hintLabel.text = newValue
        }
    }
    
    var isPasswordTextField: Bool = false {
        willSet {
                inputTextField.isSecureTextEntry = newValue
                showHidePasswordButton.setImage(newValue ? UIImage(systemName: "eye.slash.fill") :
                                                        UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    var showHidePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = Constants.inactiveColor
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    var textFieldTintColor: UIColor? {
        get {
            return .black
        }
        set {
            inputTextField.attributedPlaceholder =
            NSAttributedString(string: inputTextField.placeholder ?? "",
                               attributes: [NSAttributedString.Key.font:
                                                UIFont.roundedMplus(.bold, size: 17),
                                            NSAttributedString.Key.foregroundColor:
                                                newValue ?? UIColor.black])
        }
    }
    
    var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.inactiveColor
        return view
    }()
    
    var textFieldPlaceholder: String? {
        get {
            return self.textFieldPlaceholder
        }
        set {
            inputTextField.attributedPlaceholder =
            NSAttributedString(string: newValue ?? "",
                               attributes: [NSAttributedString.Key.font:
                                                UIFont.roundedMplus(.bold, size: 17),
                                            NSAttributedString.Key.foregroundColor:
                                                textFieldTintColor ?? UIColor.black])
        }
    }
    
    var hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.roundedMplus(.bold, size: 14)
        return label
    }()
    
    var inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.roundedMplus(.bold, size: 17)
        textField.textColor = Constants.ownBlackColor
        textField.autocapitalizationType = .none
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, hintText: String,
         hintColor: UIColor,
         inputTextFieldPlaceholder: String,
         inputTextFieldTintColor: UIColor, isPasswordTextField: Bool,
         pickerView: UIPickerView?, textFieldTag: Int) {
        super.init(frame: frame)
        hintLabel.text = hintText
        hintLabel.textColor = hintColor
        textFieldPlaceholder = inputTextFieldPlaceholder
        textFieldTintColor = inputTextFieldTintColor
        self.isPasswordTextField = isPasswordTextField
        inputTextField.isSecureTextEntry = self.isPasswordTextField
        inputTextField.inputView = pickerView
        inputTextField.tag = textFieldTag
        
        addSubview(hintLabel)
        addSubview(inputTextField)
        addSubview(underlineView)
        addSubview(showHidePasswordButton)
        
        addGestures()
    }
    
    override func layoutSubviews() {
        hintLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: hintLabel.font.lineHeight)
        
        if isPasswordTextField {
            inputTextField.frame = CGRect(x: 0, y: hintLabel.frame.maxY + 5,
                                          width: bounds.width - 45,
                                          height: inputTextField.font?.lineHeight ?? 0)
             showHidePasswordButton.frame = CGRect(x: inputTextField.frame.maxX + 5,
                                                  y: hintLabel.frame.maxY + 10,
                                                  width: 30, height: 30)
        } else {
            inputTextField.frame = CGRect(x: 0, y: hintLabel.frame.maxY + 5,
                                          width: self.bounds.width,
                                          height: inputTextField.font?.lineHeight ?? 0)
             showHidePasswordButton.frame = .zero
        }
        underlineView.frame = CGRect(x: 0, y: inputTextField.frame.maxY + 10, width: self.bounds.width, height: 2)
    }
    
    func addGestures() {
        showHidePasswordButton.addTarget(self, action: #selector(showHidePasswordAction(sender:)), for: .touchUpInside)
    }
    
    @objc func showHidePasswordAction(sender: UIButton) {
        isPasswordTextField.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
