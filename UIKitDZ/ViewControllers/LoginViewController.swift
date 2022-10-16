//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// LoginViewController - логин экран для входа в приложение
final class LoginViewController: UIViewController {
    
    // MARK: - Visual Components
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "")
        return imageView
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Constants.ownBlack)
        label.text = Constants.logoText
        label.textAlignment = .center
        return label
    }()
    
    var phoneInputView: InputView = {
        let inputView = InputView(frame: .zero,
                                  hintText: Constants.phoneTitle,
                                  hintColor: UIColor(named: Constants.ownBlueColor) ?? .systemIndigo,
                                  inputTextFieldPlaceholder: Constants.phonePlaceholder,
                                  inputTextFieldTintColor: .gray,
                                  isPasswordTextField: false, pickerView: nil, textFieldTag: 0)
        inputView.inputTextField.keyboardType = .phonePad
        return inputView
    }()
    
    var passwordInputView: InputView = {
        let inputView = InputView(frame: .zero,
                                  hintText: Constants.passwordTitle,
                                  hintColor: UIColor(named: Constants.ownBlueColor) ?? .systemIndigo,
                                  inputTextFieldPlaceholder: Constants.passwordPlaceholder,
                                  inputTextFieldTintColor: .gray,
                                  isPasswordTextField: true, pickerView: nil, textFieldTag: 0)
        return inputView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.loginButton, for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(named: Constants.ownBlueColor)
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFrames()
    }
    
    // MARK: - Public methods
    @objc func loginButtonAction() {
        navigationController?.pushViewController(FoodsViewController(), animated: true)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(logoLabel)
        view.addSubview(phoneInputView)
        view.addSubview(passwordInputView)
        view.addSubview(phoneInputView)
        view.addSubview(loginButton)
    }
    
    private func setupFrames() {
        logoImageView.frame = CGRect(x: 0, y: 140, width: 150, height: 150)
        logoImageView.center.x = view.frame.width / 2
        logoImageView.backgroundColor = .yellow
        logoLabel.frame = CGRect(x: 10, y: 0, width: view.frame.width - 20, height: logoLabel.font.pointSize)
        logoLabel.center = logoImageView.center
        phoneInputView.frame = CGRect(x: 20, y: logoImageView.frame.maxY + 20,
                                      width: view.frame.width - 40, height: 120)
        passwordInputView.frame = CGRect(x: 20, y: phoneInputView.frame.maxY - 20,
                                      width: view.frame.width - 40, height: 120)
        loginButton.frame = CGRect(x: 20, y: passwordInputView.frame.maxY, width: view.frame.width - 40, height: 44)
        
    }
    
}
