//
//  CartViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 09.10.2022.
//

import UIKit

/// CartViewController экран корзины 
final class CartViewController: UIViewController {
    
    // MARK: - Visual Components
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 24)
        label.text = Constants.cartTitle
        label.textAlignment = .center
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.greenColor
        button.layer.cornerRadius = 15
        button.setImage(UIImage(named: "filter"), for: .normal)
        return button
    }()
    
    var goToPaymentButton: UIButton = {
        let button = UIButton()
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.bold.rawValue, size: 20),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        button.setAttributedTitle(NSAttributedString(string: Constants.goToPayment, attributes: attributes),
                                  for: .normal)
        button.backgroundColor = Constants.greenColor
        button.layer.cornerRadius = 34
        return button
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.totalText
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        label.font = UIFont(name: CustomFont.medium.rawValue, size: 24)
        return label
    }()
    
    var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 28)
        label.text = Constants.rubleSign
        label.textAlignment = .right
        label.textColor = Constants.greenColor
        return label
    }()
    
    var cartTotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 32)
        label.textAlignment = .right
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var searchView = SearchView()
    
    // MARK: - Public Properties
    var productsInCartMap: [String: Product] = [:]
    var productsNamesArray: [String] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        for product in productsInCartMap {
            productsNamesArray.append(product.key)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configure()
    }
    
    // MARK: - Public methods
    func clearProductRows() {
        for view in view.subviews {
            if type(of: view) == ProductRow.self {
                view.removeFromSuperview()
            }
        }
    }
    
    @objc func goBackAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func goToFilterAction() {
        let filterViewController = FilterViewController()
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    // MARK: - Private Methods
    fileprivate func configure() {
        backButton.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 20, width: 51, height: 51)
        view.addSubview(backButton)
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 142, height: 44)
        titleLabel.center.y = backButton.center.y
        titleLabel.center.x = view.center.x
        view.addSubview(titleLabel)
        
        filterButton.frame = CGRect(x: view.frame.width - 71, y: backButton.frame.maxY + 20, width: 51, height: 51)
        view.addSubview(filterButton)
        
        searchView.frame = CGRect(x: 20, y: backButton.frame.maxY + 20, width: view.frame.width - 100, height: 51)
        view.addSubview(searchView)
        
        clearProductRows()
        
        for productIndex in 0..<productsInCartMap.count {
            let productName = productsNamesArray[productIndex]
            guard let product = productsInCartMap[productName] else { return }
            if product.count > 0 {
                let frameY = titleLabel.frame.maxY + 100.0 +  CGFloat(productIndex * (115 + 16))
                let productRow = ProductRow(frame: CGRect(x: 20.0, y: frameY,
                                                          width: (view.frame.width - 40.0), height: 115.0))
                view.addSubview(productRow)
                productRow.productImage.image = product.image
                productRow.productName.text = product.name
                productRow.productSubName.text = product.subName
                productRow.productPriceLabel.text = "\(product.price)"
            }
        }
        
        cartTotalLabel.text = "565.00"
        
        goToPaymentButton.frame = CGRect(x: 20, y: view.frame.height - 108, width: view.frame.width - 40, height: 68)
        view.addSubview(goToPaymentButton)
        
        totalLabel.frame = CGRect(x: 20, y: goToPaymentButton.frame.minY - 48,
                                  width: (view.frame.width - 40) / 2, height: totalLabel.font.pointSize)
        view.addSubview(totalLabel)
        
        cartTotalLabel.frame = CGRect(x: view.frame.width - 20 - 120, y: goToPaymentButton.frame.minY - 48,
                                      width: 120, height: cartTotalLabel.font.pointSize)
        view.addSubview(cartTotalLabel)
        
        currencyLabel.frame = CGRect(x: cartTotalLabel.frame.minX - 10, y: goToPaymentButton.frame.minY - 48,
                                     width: 20, height: currencyLabel.font.pointSize)
        view.addSubview(currencyLabel)
        
        backButton.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(goToFilterAction), for: .touchUpInside)
    }
}
