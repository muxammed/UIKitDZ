//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// это ViewController
class ViewController: UIViewController {
    
    // MARK: - Visual Components
    var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Public Properties
    var stringShuffle: StringShuffle?
    
    // MARK: - UIViewController(*)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViews()
        addGestures()
    }
    
    // MARK: - Public methods
    func addGestures() {
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
    }
    
    func setupViews() {
        self.view.backgroundColor = .systemIndigo
        self.view.addSubview(startButton)
        self.view.addSubview(resultLabel)
        
        startButton.frame.size = CGSize(width: 100, height: 40)
        startButton.center = self.view.center
        
        let labelSize = CGSize(width: self.view.frame.width - (8 * 2), height: 20)
        resultLabel.frame = CGRect(origin: CGPoint(x: 8, y: (self.view.frame.height / 2) + 28), size: labelSize)
    }
    
    @objc func startButtonAction() {
        self.showAlert(title: "Внимание!",
                       message: "Введи текст, а я его попробую разобрать, напиши \"leohl\"",
                       style: .alert,
                       textFieldsTexts: ["leohl"],
                       act: .getValueAction,
                       keyboard: .default)
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
        case .getValueAction:
            // action for getting user fio
            action = UIAlertAction(title: "Ok", style: .default) { [self] _ in
                // создание модели и передача в модель текста полученного от пользователя
                guard let enteredString = alertController.textFields?.first?.text else { return }
                stringShuffle = StringShuffle(toBeShuffled: enteredString)
                guard let result = stringShuffle?.shuffleString(toBeShuffled: enteredString) else { return }
                switch result.1 {
                case true:
                    self.showAlert(title: "Результат",
                                   message: "Я разобрался что это за слово :). Это слово \(result.0)",
                                   style: .alert,
                                   textFieldsTexts: [],
                                   act: .showOnlyMessage,
                                   keyboard: .default)
                case false:
                    // show error alert
                    self.showAlert(title: "Я же просил",
                                   message: "Я же просил введи нужное мне слово \"leohl\"",
                                   style: .alert,
                                   textFieldsTexts: [],
                                   act: .showOnlyMessage,
                                   keyboard: .default)
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
    
    // MARK: - Types

    enum AlertActions {
        case getValueAction
        case showOnlyMessage
    }
}
