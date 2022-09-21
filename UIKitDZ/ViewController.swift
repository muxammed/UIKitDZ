//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// это ViewController
class ViewController: UIViewController {

    // MARK: - Properties
    enum AlertActions {
        case sayWellcome
        case addTwoNumbers
        case none
    }
    
    var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Сложение", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var anotheButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Сложение", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var guessButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Угадай число", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var fioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add subviews and setup UI
        setupViews()
        
        // setting gestures 
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        guessButton.addTarget(self, action: #selector(guessButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAlert(title: "Внимание!",
                  message: "Введите ваше имя",
                  style: .alert,
                  textFieldsTexts: ["Введите Ваше Имя?"],
                  act: .sayWellcome,
                  keyboard: .default)
    }
    
    func setupViews() {
        
        self.view.backgroundColor = .white
        
        // adding subview to superview
        self.view.addSubview(fioLabel)
        self.view.addSubview(addButton)
        self.view.addSubview(guessButton)
        
        // set translateAutoRemask = false
        for view in self.view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // setting constraints
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            guessButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            addButton.widthAnchor.constraint(equalTo: self.guessButton.widthAnchor),
            addButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            guessButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.guessButton.leadingAnchor, constant: -8),
            
            fioLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            fioLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            fioLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
        ])
    }

    @objc func addButtonPressed() {
        print("addbutton tapped")
        showAlert(title: "Внимание!",
                  message: "Введите ваше имя",
                  style: .alert,
                  textFieldsTexts: ["1-ое число", "2-ое число"],
                  act: .addTwoNumbers,
                  keyboard: .numberPad)
    }
    
    @objc func guessButtonPressed() {
        print("guess button tapped")
    }
    
    func showAlert(title: String,
                   message: String,
                   style: UIAlertController.Style,
                   textFieldsTexts: [String],
                   act: AlertActions,
                   keyboard: UIKeyboardType) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        var action = UIAlertAction()
        
        switch act {
        case .sayWellcome:
            // action for getting user fio
            action = UIAlertAction(title: "Ok", style: .default) { _ in
                let text = alertController.textFields?.first
                self.fioLabel.text = "Привет, \(text?.text ?? "???")"
            }
        case .addTwoNumbers:
            // action for choice AddingNumbers
            action = UIAlertAction(title: "Посчитать", style: .default) { _ in
                guard let numberOne = Int(alertController.textFields?[0].text ?? "0") else {
                    self.showErrorAlert()
                    return }
                guard let numberTwo = Int(alertController.textFields?[1].text ?? "0") else {
                    self.showErrorAlert()
                    return }
                let result = numberOne + numberTwo
                self.showAlert(title: "Результат",
                               message: "Сумма цифр = \(result)",
                               style: .alert,
                               textFieldsTexts: [],
                               act: .none,
                               keyboard: .default)
            }
        default:
            action = UIAlertAction(title: "Ok", style: .default)
        }
        
        for textField in textFieldsTexts {
            alertController.addTextField { textFieldTemp in
                textFieldTemp.placeholder = textField
                textFieldTemp.keyboardType = keyboard
            }
        }
            
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        self.showAlert(title: "Ошибка",
                       message: "Неверный формат введенных чисел",
                       style: .alert,
                       textFieldsTexts: [],
                       act: .none,
                       keyboard: .default)
    }
}
