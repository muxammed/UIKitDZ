//
//  SecondTabController.swift
//  UIKitDZ
//
//  Created by muxammed on 17.10.2022.
//

import UIKit

/// SecondTabController пустой экран
final class SecondTabController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.tabTwoName
    }
}
