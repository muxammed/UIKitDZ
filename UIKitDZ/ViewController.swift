//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit

/// Константы 
struct Constants {
    static let tabOnaName = "First Tab"
    static let tabTwoName = "Second Tab"
    static let tabOneIcon = "tray.fill"
    static let tabTwoIcon = "archivebox.fill"
    static let plusIcon = "plus"
    static let okeyText = "Готово"
    static let placeholderText = "Введите текст"
    static let alertText = "Введите текст для лейбла"
}

/// это тестовый ViewController
class ViewController: UITabBarController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private method
    private func configure() {
        view.backgroundColor = .white
        let firstTab = UINavigationController(rootViewController: FirstTabController())
        let secondTab = UINavigationController(rootViewController: SecondTabController())
        let icon1 = UITabBarItem(title: Constants.tabOnaName, image: UIImage(systemName: Constants.tabOneIcon),
                                 selectedImage: UIImage(systemName: Constants.tabOneIcon))
        firstTab.tabBarItem = icon1
        let icon2 = UITabBarItem(title: Constants.tabTwoName, image: UIImage(systemName: Constants.tabTwoIcon),
                                 selectedImage: UIImage(systemName: Constants.tabTwoIcon))
        secondTab.tabBarItem = icon2
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .darkGray
        setViewControllers([firstTab, secondTab], animated: true)
    }
}
