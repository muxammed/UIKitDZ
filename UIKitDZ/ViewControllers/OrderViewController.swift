//
//  OrderViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 16.10.2022.
//

import UIKit

/// PayButtonClickedDelegate - протокол для делегирования нажатия кнопки оплата
protocol PayButtonClickedDelegate: AnyObject {
    func payButtonClicked(withOrder: Order)
}

/// SwitchIngridientDelegate - протокол для делегирования переключателей ингридиентов
protocol SwitchIngridientDelegate: AnyObject {
    func switchIngridient(named: String, isSelected: Bool)
}

/// OrderViewController - экран с показом содержания заказа пиццы и ингридиентов с кнопкой оплаты
final class OrderViewController: UIViewController {
    
    // MARK: - Visual Components
    var pizzaName: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    var pizzaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let payButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.selectText, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Public Properties
    weak var delegate: PayButtonClickedDelegate?
    let ingridients = [Constants.ingridientOne, Constants.ingridientTwo,
                       Constants.ingridientThree, Constants.ingridientFour]
    var createdOrder: Order?
    var selectedPizza: Pizza?
    
    // MARK: - Initializers
    init(withPizza: Pizza) {
        super.init(nibName: nil, bundle: nil)
        pizzaName.text = withPizza.name
        pizzaImage.image = UIImage(named: withPizza.imageName)
        createdOrder = Order(pizza: withPizza, ingredients: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public methods
    @objc func goToPayment() {
        guard let createdOrder = createdOrder else { return }
        delegate?.payButtonClicked(withOrder: createdOrder)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(payButton)
        view.addSubview(pizzaName)
        view.addSubview(pizzaImage)
        payButton.addTarget(self, action: #selector(goToPayment), for: .touchUpInside)
        
        view.layoutSubviews()
        
        payButton.frame = CGRect(x: 0, y: view.frame.height - 144, width: view.frame.width - 80, height: 54)
        payButton.center.x = view.center.x
        pizzaName.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: pizzaName.font.pointSize)
        pizzaName.center.x = view.center.x
        pizzaImage.frame = CGRect(x: 0, y: pizzaName.frame.maxY + 20,
                                  width: view.frame.width - 80, height: view.frame.width - 80)
        pizzaImage.center.x = view.center.x
        
        for index in 0..<ingridients.count {
            let ingridientView = IngredientView(withIngridient: ingridients[index])
            ingridientView.delegate = self
            view.addSubview(ingridientView)
            let height = CGFloat(Int(pizzaImage.frame.maxY) + 20 + (54 * index))
            ingridientView.frame = CGRect(x: 40, y: height, width: view.frame.width - 80, height: 44)
        }
        view.layoutSubviews()
    }
}

/// SwitchIngridientDelegate
extension OrderViewController: SwitchIngridientDelegate {
    func switchIngridient(named: String, isSelected: Bool) {
        if isSelected {
            createdOrder?.ingredients.append(named)
        } else {
            if let ind = createdOrder?.ingredients.firstIndex(of: named) {
                createdOrder?.ingredients.remove(at: ind)
            }
        }
    }
}
