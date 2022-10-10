//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// Урок 15 коды из видео
class LessonViewController: UIViewController {

//    @IBOutlet var myButtons: [UIButton]!
    
    var myButton = UIButton()
    let normalImage = UIImage(named: "1")
    let highlightedImage = UIImage(named: "2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        myButton = UIButton(type: .roundedRect)
        myButton.frame = CGRect(x: 110, y: 200, width: 100, height: 44)
        myButton.setTitle("1", for: .normal)
        myButton.setTitle("2", for: .highlighted)
        myButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchDown)
        myButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        view.addSubview(myButton)
        
        myButton.setBackgroundImage(normalImage, for: .normal)
        myButton.setBackgroundImage(highlightedImage, for: .highlighted)
        
//        for button in myButtons {
//            button.setTitleColor(.green, for: .normal)
//            print("")
//        }
    }
    
    @objc func buttonIsPressed(sender: UIButton) {
        print("Button is pressed")
    }
    
    @objc func buttonIsTapped(sender: UIButton) {
        print("Button is tapped")
    }
    
//
//    @IBAction func buttonAction(_ sender: Any) {
//        guard let button = sender as? UIButton else { return }
//        if button.titleLabel?.text == "Button1" {
//            print("Это первая кнопка")
//        } else if button.tag == 3 {
//            print("Это третья кнопка")
//        }
//
//    }
    
}
