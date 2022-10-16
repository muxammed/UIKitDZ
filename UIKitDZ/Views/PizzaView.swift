//
//  PizzaView.swift
//  UIKitDZ
//
//  Created by muxammed on 16.10.2022.
//

import UIKit

/// PizzaView - кастомный вьюв для вывода фото и названия пиццы и переиспользования
final class PizzaView: UIView {
    
    // MARK: - Visual Components
    let pizzaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let pizzaName: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 27, weight: .regular)
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        return button
    }()
    
    // MARK: - Public Properties
    weak var delegate: PizzaAddButtonClickedDelegate?
    var pizza: Pizza?
    
    // MARK: - Initializers
    init(withPizza: Pizza) {
        super.init(frame: .zero)
        configure(withPizza: withPizza)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    override func layoutSubviews() {
        pizzaImage.frame = CGRect(x: 10, y: 10, width: 130, height: 130)
        pizzaName.frame = CGRect(x: pizzaImage.frame.maxX + 10, y: 0,
                                 width: frame.width - 220, height: pizzaName.font.pointSize)
        pizzaName.center.y = pizzaImage.center.y
        addButton.frame = CGRect(x: pizzaName.frame.maxX + 10, y: 0, width: 40, height: 40)
        addButton.center.y = pizzaName.center.y
        
    }
    
    @objc func addButtonAction() {
        guard let pizza = pizza else { return }
        delegate?.pizzaAddButtonClicked(pizza: pizza)
    }
    
    // MARK: - Private Methods
    private func configure(withPizza: Pizza) {
        setupViews()
        pizzaImage.image = UIImage(named: withPizza.imageName)
        pizzaName.text = withPizza.name
        pizza = withPizza
    }
    
    private func setupViews() {
        addSubview(pizzaImage)
        addSubview(pizzaName)
        addSubview(addButton)
        backgroundColor = .white
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
}
