//
//  FoodsViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 14.10.2022.
//

import UIKit

/// FoodsViewController - экран список блюд
final class FoodsViewController: UIViewController {
    
    // MARK: - Visual Components
    let pizzaButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.setTitle(Constants.pizzaButtonTitle, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let sushiButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.5
        button.setTitle(Constants.sushiButtonTitle, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    // MARK: - Public methods
    @objc func goToPizzasAction() {
        navigationController?.pushViewController(PizzasViewController(), animated: true)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(pizzaButton)
        view.addSubview(sushiButton)
        pizzaButton.addTarget(self, action: #selector(goToPizzasAction), for: .touchUpInside)
    }
    
    private func configure() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.backButtonTitle,
                                                           style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.setHidesBackButton(true, animated: true)
        let attr = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = attr
        title = Constants.foodsTitle
        
        pizzaButton.frame = CGRect(x: 10, y: 150, width: view.frame.width - 20, height: 100)
        sushiButton.frame = CGRect(x: 10, y: pizzaButton.frame.maxY + 20, width: view.frame.width - 20, height: 100)
    }
}
