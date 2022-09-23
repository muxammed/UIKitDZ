//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// это ViewController
class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goToRegister(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let regVC = storyboard.instantiateViewController(identifier: "registerVC")
                                            as? RegisterViewController {
            regVC.fio = self.emailTextField.text ?? ""
            self.navigationController?.pushViewController(regVC, animated: true)
        }
        
    }
}
