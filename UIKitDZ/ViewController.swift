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
        case generateGuessNumber
        case checkGuessNumber
        case none
    }
    
    var guessNumber: Int?
    var attemps = 3
    // MARK: - you can switch between autolayout and manual frame placing views
    var viaAutoLayout = true
    
    var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemIndigo.cgColor, UIColor.systemIndigo.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        return gradient
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Сложение", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var guessButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Угадай число", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var fioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // add subviews and setup UI
        setupViews()
    }
    
    func setupViews() {
        
        // self.view.backgroundColor = .white
        
        self.gradient.frame = self.view.layer.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        // adding subview to superview
        self.view.addSubview(fioLabel)
        self.view.addSubview(addButton)
        self.view.addSubview(guessButton)
        
        if viaAutoLayout {
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
                addButton.heightAnchor.constraint(equalToConstant: 40),
                guessButton.heightAnchor.constraint(equalToConstant: 40),
                
                fioLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
                fioLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
                fioLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            ])
        } else {
            // draw and place views manually
            // placing label on top 50p down to save area
            let labelSize = CGSize(width: self.view.frame.width - 16, height: 20)
            fioLabel.frame.size = labelSize
            fioLabel.frame = CGRect(origin:
                                        CGPoint(x: (self.view.frame.width - fioLabel.frame.width) / 2,
                                                y: self.view.safeAreaInsets.top + 50),
                                    size: labelSize)
            
            // placing two buttons with same width on a center of superView
            let buttonSize = CGSize(width: (self.view.frame.width - (8 * 3)) / 2, height: 40)
            addButton.frame.size = buttonSize
            addButton.frame = CGRect(origin:
                                        CGPoint(x: 8,
                                                y: (self.view.frame.height - addButton.frame.height) / 2),
                                     size: buttonSize)
            guessButton.frame.size = buttonSize
            guessButton.frame = CGRect(origin:
                                        CGPoint(x: self.addButton.frame.width + (8 * 2),
                                                y: (self.view.frame.height - guessButton.frame.height) / 2),
                                     size: buttonSize)
        }
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
        showAlert(title: "Игра угадайка",
                  message: "Введи целое число. А я загадаю число до этого значения.",
                  style: .alert,
                  textFieldsTexts: ["целое число"],
                  act: .generateGuessNumber,
                  keyboard: .numberPad)
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
            action = UIAlertAction(title: "Ok", style: .default) { [self] _ in
                let text = alertController.textFields?.first
                fioLabel.text = "Привет, \(text?.text ?? "???")"
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
        case .generateGuessNumber:
            // action for generating random for
            action = UIAlertAction(title: "Ok", style: .default) { [self] _ in
                guard let numberForRandom = Int(alertController.textFields?[0].text ?? "0") else {
                    showErrorAlert()
                    return }
                
                if numberForRandom <= 0 {
                    showErrorAlert()
                    return
                }
                
                guessNumber = Int.random(in: 0..<numberForRandom)
                print("random number \(guessNumber ?? 0)")
                showAlert(title: "Угадывай :)",
                               message: "Я загадал угадывай! У тебя \(attemps) попытки.",
                               style: .alert,
                               textFieldsTexts: ["целое число"],
                               act: .checkGuessNumber,
                               keyboard: .numberPad)
            }
        case .checkGuessNumber:
            // action for checking guessnumber
            action = UIAlertAction(title: "Ok", style: .default) { [self] _ in
                guard let enteredNumber = Int(alertController.textFields?[0].text ?? "0") else {
                    showErrorAlert()
                    return }
                attemps -= 1
                print("attemos \(attemps)")
                
                if guessNumber == enteredNumber {
                    self.showAlert(title: "УРАААА",
                                   message: "Поздравляю, Ты угадал",
                                   style: .alert,
                                   textFieldsTexts: [],
                                   act: .none,
                                   keyboard: .default)
                    attemps = 3
                    animateColor(color: .green)
                } else {
                    animateColor(color: .red)
                    if attemps > 0 {
                        showAlert(title: ":( Неверно",
                                       message: "Попробуй еще раз! Осталось \(attemps) попыток.",
                                       style: .alert,
                                       textFieldsTexts: ["целое число"],
                                       act: .checkGuessNumber,
                                       keyboard: .numberPad)
                    } else {
                        showAlert(title: ":( Больше попыток нету",
                                       message: "Извини больше попыток нету начинай игру заново!",
                                       style: .alert,
                                       textFieldsTexts: [],
                                       act: .none,
                                       keyboard: .default)
                        attemps = 3
                    }
                    
                }
                
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
        self.attemps = 3
    }
    
    func animateColor(color: UIColor) {
        self.gradient.colors = [color.cgColor, UIColor.systemIndigo.cgColor]
        UIView.animate(withDuration: 1) {
            self.gradient.layoutIfNeeded()
        }
    }
}
