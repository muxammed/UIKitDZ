//
//  LessonViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 07.10.2022.
//

import Foundation
import UIKit

/// код из урока 14
class LessonViewController: UIViewController {
    
//    var myTextView = UITextView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        createTextView()
//        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(param:)), name: UIResponder.keyboardDidShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(param:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    
//    @objc func updateTextView(param: Notification) {
//        let userInfo = param.userInfo
//        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue).cgRectValue
//        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
//        
//        if param.name == UIResponder.keyboardWillHideNotification {
//            myTextView.contentInset = UIEdgeInsets.zero
//        } else {
//            myTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
//            myTextView.scrollIndicatorInsets = myTextView.contentInset
//        }
//        
//        myTextView.scrollRangeToVisible(myTextView.selectedRange)
//    }
//    
//    fileprivate func createTextView() {
//        self.view.backgroundColor = .white
//        
//        myTextView = UITextView(frame:
//                                    CGRect(x: 20, y: 100,
//                                           width: self.view.bounds.width - 40,
//                                           height: self.view.bounds.height / 2))
//        myTextView.text = "Some text"
//        myTextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
//        myTextView.font = UIFont.systemFont(ofSize: 17)
//        myTextView.backgroundColor = .gray
//        self.view.addSubview(myTextView)
//    }

}
