//
//  RegisterViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 23.09.2022.
//

import UIKit

/// RegisterViewController
class RegisterViewController: UIViewController {
    
    var fio: String?
    @IBOutlet weak var fioTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fioTextField.text = fio ?? ""
    }
    
    @IBAction func goToCheckOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "Выставить чек?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Чек", style: .default, handler: { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let regVC = storyboard.instantiateViewController(identifier: "checkOut")
                                                as? CheckOutViewController {
                self.navigationController?.pushViewController(regVC, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
