//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// это тестовый ViewController
class ViewController: UIViewController {
    
    var stringShuffle: StringShuffle?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = .systemIndigo
        self.view.addSubview(startButton)
        self.view.addSubview(resultLabel)
        
        startButton.frame.size = CGSize(width: 100, height: 40)
        startButton.center = self.view.center
        
        let labelSize = CGSize(width: self.view.frame.width - (8 * 2), height: 20)
        resultLabel.frame = CGRect(origin: CGPoint(x: 8, y: (self.view.frame.height / 2) + 28), size: labelSize)
        
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
    }
    
    @objc func startButtonAction() {
        // создание модели и передача в модель текста полученного от пользователя
        stringShuffle = StringShuffle(toBeShuffled: "hello")
        guard let result = stringShuffle?.shuffleString(toBeShuffled: "hello") else { return }
        switch result.1 {
        case true:
            print("print success alert")
        case false:
            print("show error alert")
        }
    }
}
