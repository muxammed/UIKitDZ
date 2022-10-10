//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// ViewController коды из 8го урока
class LessonViewController: UIViewController, UITextFieldDelegate {

    var buttonShare = UIButton()
    var textField = UITextField()
    var activityViewController: UIActivityViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        createTextField()
        createButton()
        textField.delegate = self
    }
    
    // MARK: - Method
    func createTextField() {
        textField.frame = CGRect(x: 0, y: 0, width: 280, height: 30)
        textField.center = view.center
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text to share"
        view.addSubview(textField)
    }
    
    func createButton() {
        buttonShare = UIButton(type: .roundedRect)
        buttonShare.frame = CGRect(x: 50, y: 350, width: 280, height: 44)
        buttonShare.setTitle("Share", for: .normal)
        buttonShare.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        view.addSubview(buttonShare)
    }
    
    @objc func handleShare(paramSender: Any) {
        let text = textField.text
        if text?.count == 0 {
            let message = "Сначало введите текст, потом нажмите кнопку"
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        
        activityViewController = UIActivityViewController(activityItems: [textField.text ?? "nil"],
                                                          applicationActivities: nil)
        guard let activityVC = activityViewController else { return }
        present(activityVC, animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
