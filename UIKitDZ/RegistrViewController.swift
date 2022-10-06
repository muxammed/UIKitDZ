//
//  RegistrViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 06.10.2022.
//

import Foundation
import UIKit

/// константы
struct Constants {
    static let isRegistered = "hasRegistered"
}

/// класс регистрации при регистрации идет отметка что девайс регистрирован в UserDefaults и перед появлением в ViewWillAppear идет проверка имеется ли запись регистрирован если имеется проходит автоматом дальше если нет тогда открывается данный ViewController
final class RegisterViewController: UIViewController {
        
    // MARK: - IBOutlet
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - UIViewController(*)
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.bool(forKey: Constants.isRegistered) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: self.nibBundle)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "secondVC")
            navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        surnameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHided(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - Public methods
    func setAlphaToViews(to: CGFloat) {
        for view in contentView.subviews {
            view.alpha = to
        }
    }
    
    @objc func keyboardShown(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let heightToForUp = (self.view.frame.height - registerButton.frame.origin.y) + registerButton.frame.height
            self.view.frame.origin.y = keyboardHeight - heightToForUp
        }
    }
    
    @objc func keyboardHided(_ notification: Notification) {
        
        view.frame.origin.y = 0
    }
    
    // MARK: - IBAction
    @IBAction func registerButtonAction(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: Constants.isRegistered)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: self.nibBundle)
        // пришлось скоротить имя переменной изза 120 символов в строке
        guard let secondVC = storyboard.instantiateViewController(withIdentifier:
                                                                    "secondVC") as? SecondViewController else { return }
        
        secondVC.name = nameTextField.text
        secondVC.surname = surnameTextField.text
        navigationController?.pushViewController(secondVC, animated: true)
        
    }
    // MARK: - Private Methods
    fileprivate func setupViews() {
        view.backgroundColor = .yellow
        topLabel.text = """
                    Хочу
                    на море
                    """
        contentView.frame.origin.y = view.frame.height + contentView.frame.height
        UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseInOut) {
            self.contentView.frame.origin.y = self.view.frame.height - self.contentView.frame.height + 80
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.setAlphaToViews(to: 1.0)
            }
        }
    }
    // MARK: - Types
    
    // MARK: - Constants
}

/// UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            surnameTextField.becomeFirstResponder()
        case surnameTextField:
            phoneTextField.becomeFirstResponder()
        case phoneTextField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
