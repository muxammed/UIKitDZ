//
//  IngredientView.swift
//  UIKitDZ
//
//  Created by muxammed on 16.10.2022.
//

import UIKit

/// IngredientView - кастомный вьюв для показа и переиспользования строк ингридиентов
class IngredientView: UIView {
    
    // MARK: - Visual Components
    let ingrediantLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        return label
    }()
    
    let ingredientSwitcher: UISwitch = {
        let swith = UISwitch()
        swith.onTintColor = .green
        return swith
    }()
    // MARK: - Public Properties
    weak var delegate: SwitchIngridientDelegate?
    
    // MARK: - Initializers
    init(withIngridient: String) {
        super.init(frame: .zero)
        ingrediantLabel.text = withIngridient
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    @objc func switchIngridientAction(_ sender: UISwitch) {
        delegate?.switchIngridient(named: ingrediantLabel.text ?? "", isSelected: sender.isOn)
    }
    
    override func layoutSubviews() {
        ingrediantLabel.frame = CGRect(x: 0, y: 0, width: frame.width - 50,
                                       height: ingrediantLabel.font.pointSize)
        ingrediantLabel.center.y = frame.height / 2
        ingredientSwitcher.frame = CGRect(x: ingrediantLabel.frame.maxX + 8, y: 0, width: 50, height: 44)
        ingredientSwitcher.center.y = ingrediantLabel.center.y
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        addSubview(ingrediantLabel)
        addSubview(ingredientSwitcher)
        ingredientSwitcher.addTarget(self, action: #selector(switchIngridientAction(_:)), for: .valueChanged)
    }
}
