//
//  PaymentViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 16.10.2022.
//

import UIKit

/// PaymentViewController экран оплаты заказа
final class PaymentViewController: UIViewController {
    
    // MARK: - Visual Components
    let payButton: UIButton = {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.filled()
        config.title = Constants.payText
        config.background.backgroundColor = .black
        config.image = UIImage(systemName: Constants.applelogo,
                               withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        button.configuration = config
        return button
    }()
    
    let yourOrderLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.yourOrderText
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        return label
    }()
    
    let pizzaNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 37, weight: .bold)
        return label
    }()
    
    let cardPaymentView: PaymentTypeView = {
        let paymentView = PaymentTypeView(withIngridient: Constants.payWithCardText)
        paymentView.ingredientSwitcher.isOn = true
        return paymentView
    }()
    
    let cashPaymentView: PaymentTypeView = {
        let paymentView = PaymentTypeView(withIngridient: Constants.payWithCashText)
        return paymentView
    }()
    
    // MARK: - Public Properties
    var order: Order?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Public methods
    @objc func payButtonAction() {
        showAlert(title: Constants.orderPayedText, message: Constants.orderPayedAlertMessage)
    }
    
    // MARK: - Private Methods
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(payButton)
        payButton.frame = CGRect(x: 0, y: view.frame.height - 84, width: view.frame.width - 80, height: 54)
        payButton.center.x = view.center.x
        payButton.addTarget(self, action: #selector(payButtonAction), for: .touchUpInside)
        title = Constants.paymentTitle
        
        view.addSubview(yourOrderLabel)
        yourOrderLabel.frame = CGRect(x: 20, y: 120, width: view.frame.width - 40,
                                      height: yourOrderLabel.font.pointSize)
        view.addSubview(pizzaNameLabel)
        pizzaNameLabel.frame = CGRect(x: 20, y: yourOrderLabel.frame.maxY + 10, width: view.frame.width - 40,
                                      height: pizzaNameLabel.font.pointSize)
        addOrderSummary()
        addPaymentMethods()
    }
    
    private func addOrderSummary() {
        guard let order = order else { return }
        pizzaNameLabel.text = "\(1)  \(order.pizza.name)"
        for ind in 0..<order.ingredients.count {
            let label = UILabel()
            label.text = "\(ind + 2)  \(order.ingredients[ind])"
            label.font = UIFont.systemFont(ofSize: 37, weight: .bold)
            label.textColor = UIColor.darkGray
            var height = CGFloat(CGFloat(pizzaNameLabel.frame.maxY + 10))
            height += CGFloat(Int(label.font.pointSize + 10) * ind)
            label.frame = CGRect(x: 20, y: height, width: view.frame.width - 40, height: label.font.pointSize)
            view.addSubview(label)
        }
        view.layoutSubviews()
    }
    
    private func addPaymentMethods() {
        view.addSubview(cardPaymentView)
        cardPaymentView.delegate = self
        cardPaymentView.frame = CGRect(x: 0, y: payButton.frame.minY - 74,
                                       width: view.frame.width - 80, height: 54)
        cardPaymentView.center.x = view.center.x
        
        view.addSubview(cashPaymentView)
        cashPaymentView.delegate = self
        cashPaymentView.frame = CGRect(x: 0, y: cardPaymentView.frame.minY - 40,
                                       width: view.frame.width - 80, height: 54)
        cashPaymentView.center.x = view.center.x
        view.layoutSubviews()
    }
}

/// PaymentViewController - расширение для показа алерта
extension PaymentViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: Constants.okeyText, style: .default) { [weak self] _ in
            guard let self = self,
                  let viewControllers = self.navigationController?.viewControllers else { return }
            for viewController in viewControllers where viewController is FoodsViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
        alertController.addAction(okeyAction)
        present(alertController, animated: true, completion: nil)
    }
}

/// SwitchIngridientDelegate
extension PaymentViewController: SwitchIngridientDelegate {
    func switchIngridient(named: String, isSelected: Bool) {
        if named == Constants.payWithCashText {
            cardPaymentView.ingredientSwitcher.isOn = !isSelected
        } else {
            cashPaymentView.ingredientSwitcher.isOn = !isSelected
        }
    }
}
