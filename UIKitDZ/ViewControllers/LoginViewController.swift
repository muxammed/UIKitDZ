//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

/// Константы для использования везде в приложении
struct Constants {
    static let pinkColor: UIColor = UIColor(red: 161 / 255, green: 191 / 255, blue: 242 / 255, alpha: 1)
    static let inactiveColor: UIColor = UIColor(red: 209 / 255, green: 211 / 255, blue: 217 / 255, alpha: 1)
    static let ownBlackColor: UIColor = UIColor(red: 92 / 255, green: 92 / 255, blue: 92 / 255, alpha: 1)
 }

import UIKit
/// это LoginViewController - для входа в приложение вводом емайла и пароля
final class LoginViewController: UIViewController {

    // MARK: - Visual Components
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.pinkColor
        button.setAttributedTitle(
            NSAttributedString(string: "Войти",
                               attributes: [NSAttributedString.Key.font: UIFont.roundedMplus(.bold, size: 20)]),
                                for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let borderedView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.pinkColor
        label.text = "Birthday Reminder"
        label.font = UIFont.roundedMplus(.bold, size: 17)
        label.textAlignment = .center
        return label
    }()
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Sign In"
        label.font = UIFont.roundedMplus(.extrabold, size: 26)
        return label
    }()
    
    let emailInput: InputView = {
        let inputView = InputView(frame: .zero, hintText: "Email",
                                  hintColor: Constants.pinkColor,
                                  inputTextFieldPlaceholder: "example@email.com",
                                  inputTextFieldTintColor: Constants.inactiveColor,
                                  isPasswordTextField: false,
                                  pickerView: nil,
                                  textFieldTag: 0)
        return inputView
    }()
    
    let passwordInput: InputView = {
        let inputView = InputView(frame: .zero, hintText: "Password",
                                  hintColor: Constants.pinkColor,
                                  inputTextFieldPlaceholder: "your password",
                                  inputTextFieldTintColor: Constants.inactiveColor,
                                  isPasswordTextField: true,
                                  pickerView: nil,
                                  textFieldTag: 0)
        return inputView
    }()
    
    let entrySwitcherLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход по Face ID"
        label.textColor = Constants.ownBlackColor
        label.font = UIFont.roundedMplus(.black, size: 14)
        label.textAlignment = .right
        return label
    }()
    
    let faceIdSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        return switcher
    }()

    // MARK: - UIViewController(*)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViews()
    }
    // MARK: - Public methods
    func setupViews() {
        
        view.backgroundColor = .white
        view.addSubview(loginButton)
        view.addSubview(borderedView)
        borderedView.addSubview(appTitleLabel)
        view.addSubview(signInLabel)
        view.addSubview(emailInput)
        view.addSubview(passwordInput)
        view.addSubview(entrySwitcherLabel)
        view.addSubview(faceIdSwitcher)
        
        let paddingForBorderView = (self.view.frame.width - 180) / 2
        borderedView.frame = CGRect(x: paddingForBorderView, y: view.safeAreaInsets.top, width: 180, height: 70)
        appTitleLabel.frame.origin = CGPoint(x: 0, y: 0)
        appTitleLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 70)
        signInLabel.frame = CGRect(x: 40, y:
                                    borderedView.frame.maxY + 70,
                                   width: self.view.frame.width - 80,
                                   height: signInLabel.font.lineHeight)
        emailInput.frame = CGRect(x: 40, y: signInLabel.frame.maxY + 20, width: self.view.frame.width - 80, height: 80)
        passwordInput.frame = CGRect(x: 40, y: emailInput.frame.maxY,
                                     width: self.view.frame.width - 80, height: 80)
        faceIdSwitcher.frame = CGRect(x: view.frame.width - 40 - 50 - 10,
                                          y: passwordInput.frame.maxY + 10,
                                          width: 50, height: entrySwitcherLabel.font.lineHeight)
        entrySwitcherLabel.frame = CGRect(x: 40, y: passwordInput.frame.maxY + 10,
                                          width: view.frame.width - 80 - 50 - 20,
                                          height: entrySwitcherLabel.font.lineHeight)
        entrySwitcherLabel.center.y = faceIdSwitcher.center.y
        loginButton.frame = CGRect(x: 40, y: entrySwitcherLabel.frame.maxY + 60,
                                   width: view.frame.width - 80, height: 50)
        
        addGestures()
    }
    
    func addGestures() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    @objc func loginButtonAction() {
        navigationController?.pushViewController(BirthdaysViewController(), animated: true)
    }
   
}
/// разширение для Шрифта подключает перечисление со сторонним шрифтом для удобного переключения
extension UIFont {
    
    enum RoundedMPlusFont {
        case black
        case bold
        case extrabold
        case medium
        case light
        case regular
        case thin
        case custom(String)
            
        var value: String {
            switch self {
            case .black:
                return "RoundedMplus1c-Black"
            case .bold:
                return "RoundedMplus1c-Bold"
            case .extrabold:
                return "RoundedMplus1c-ExtraBold"
            case .light:
                return "RoundedMplus1c-Light"
            case .medium:
                return "RoundedMplus1c-Medium"
            case .regular:
                return "RoundedMplus1c-Regular"
            case .thin:
                return "RoundedMplus1c-Thin"
            case .custom(let name):
                return name
            }
        }
    }
        
    static func roundedMplus(_ type: RoundedMPlusFont, size: CGFloat = 26) -> UIFont {
        return UIFont(name: type.value, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
