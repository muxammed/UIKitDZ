//
//  InputView.swift
//  UIKitDZ
//
//  Created by muxammed on 13.10.2022.
//

import UIKit

/// кастомный InputView что бы переиспользовать включает в себя настраиваемые по цвету и подскажке UILabel, UITextField, также есть возможность определить UITextField как поле ввода пароля
/// - Parameters
///  - hintText: Текст для UILabel  сверху UITextField
///  - hintColor: Цвет для UILabel  сверху UITextField
///  - inputTextFieldPlaceholder: Текст подсказка для UITextField
///  - inputTextFieldTintColor: Цвет подсказки UITextField
///  - isPasswordTextField: Переключатель в случаи истина UITextField станет password и появится кнопка для вскрытия/сокрытия пароля
///  - pickerView: экзепляр UIPickerView для назначение его inputView'ом внутреннего UITextField'a
///  - textFieldTag: Int число прописывается как tag UITextField для разделения в методах прокола UITextFieldDelegate, UITextFieldDataSource
final class InputView: UIView {
    
    // MARK: - Visual Components
    var showHidePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = .gray
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = UIColor(named: Constants.ownBlackColor)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    // MARK: - Public Properties
    var hintColor: UIColor? {
        get {
            return _hintColor
        }
        set {
            _hintColor = newValue ?? .black
        }
    }
    
    var hintText: String? {
        get {
            return _hintText
        }
        set {
            _hintText = newValue ?? ""
        }
    }
    
    var isPasswordTextField: Bool = false {
        willSet {
                inputTextField.isSecureTextEntry = newValue
                showHidePasswordButton.setImage(newValue ? UIImage(systemName: "eye.slash.fill") :
                                                        UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    var textFieldTintColor: UIColor? {
        willSet {
            inputTextField.attributedPlaceholder =
            NSAttributedString(string: inputTextField.placeholder ?? "",
                               attributes: [NSAttributedString.Key.font:
                                                UIFont.systemFont(ofSize: 17, weight: .thin),
                                            NSAttributedString.Key.foregroundColor:
                                                newValue ?? UIColor.black])
        }
    }
    
    var textFieldPlaceholder: String? {
        willSet {
            inputTextField.attributedPlaceholder =
            NSAttributedString(string: newValue ?? "",
                               attributes: [NSAttributedString.Key.font:
                                                UIFont.systemFont(ofSize: 17, weight: .thin),
                                            NSAttributedString.Key.foregroundColor:
                                                textFieldTintColor ?? UIColor.black])
        }
    }
    
    // MARK: - Private Properties
    private var innerHintColor = UIColor()
    private var _hintColor: UIColor?
    private var _hintText: String = ""
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, hintText: String, hintColor: UIColor, inputTextFieldPlaceholder: String,
         inputTextFieldTintColor: UIColor, isPasswordTextField: Bool, pickerView: UIPickerView?, textFieldTag: Int) {
        super.init(frame: frame)
        _hintColor = hintColor
        _hintText = hintText
        textFieldPlaceholder = inputTextFieldPlaceholder
        textFieldTintColor = inputTextFieldTintColor
        self.isPasswordTextField = isPasswordTextField
        inputTextField.inputView = pickerView
        inputTextField.tag = textFieldTag
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    override func layoutSubviews() {
        setupViews()
    }
    
    @objc func showHidePasswordAction(sender: UIButton) {
        isPasswordTextField.toggle()
    }
    
    // MARK: - Private Methods
    private func configure() {
        hintLabel.text = _hintText
        hintLabel.textColor = _hintColor
        inputTextField.isSecureTextEntry = isPasswordTextField
        inputTextField.delegate = self
        
        addSubview(hintLabel)
        addSubview(inputTextField)
        addSubview(underlineView)
        addSubview(showHidePasswordButton)
        
        addGestures()
    }
    
    private func setupViews() {
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
    
    private func addGestures() {
        showHidePasswordButton.addTarget(self, action: #selector(showHidePasswordAction(sender:)), for: .touchUpInside)
    }
}

/// UITextFieldDelegate
extension InputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
