//
//  PizzasViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 15.10.2022.
//

import UIKit

/// протокол делегат для обработки нажатия кнопки плюса внутри кастомного вьюхи пиццы
protocol PizzaAddButtonClickedDelegate: AnyObject {
    func pizzaAddButtonClicked(pizza: Pizza)
}

/// PizzasViewController - экран вывода списком пиц
final class PizzasViewController: UIViewController {
    
    // MARK: - Public Properties
    var pizzas: [Pizza] = [Pizza]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.backButtonTitle,
                                                           style: .plain, target: nil, action: nil)
        let attr = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = attr
        title = Constants.pizzasTitle
        
        loadPizzas()
    }
    
    private func loadPizzas() {
        pizzas.append(Pizza(imageName: Constants.pizzaOneImage, name: Constants.pizzaNameOne))
        pizzas.append(Pizza(imageName: Constants.pizzaTwoImage, name: Constants.pizzaNameTwo))
        
        for index in 0..<pizzas.count {
            let pizza = PizzaView(withPizza: pizzas[index])
            pizza.delegate = self
            let pizzaHeight = CGFloat(100 + (150 * index))
            pizza.frame = CGRect(x: 10, y: pizzaHeight, width: view.frame.width - 20, height: 150)
            view.addSubview(pizza)
        }
        
    }
}

/// OrderAddButtonClickedDelegate
extension PizzasViewController: PizzaAddButtonClickedDelegate {
    
    func pizzaAddButtonClicked(pizza: Pizza) {
        let orderVC = OrderViewController(withPizza: pizza)
        orderVC.selectedPizza = pizza
        orderVC.delegate = self
        present(orderVC, animated: true, completion: nil)
    }
}

/// PayButtonClickedDelegate
extension PizzasViewController: PayButtonClickedDelegate {
    func payButtonClicked(withOrder: Order) {
        let paymentViewController = PaymentViewController()
        paymentViewController.order = withOrder
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
}
