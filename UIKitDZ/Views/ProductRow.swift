//
//  ProductRow.swift
//  UIKitDZ
//
//  Created by muxammed on 09.10.2022.
//

import UIKit

/// Кастомный вьюв переиспользования для показа продукции в корзине 
final class ProductRow: UIView {
    
    var productRow: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1).cgColor
        view.backgroundColor = .white
        return view
    }()
    
    var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var productName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 16)
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var productSubName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.light.rawValue, size: 16)
        label.textColor = UIColor(red: 124 / 255, green: 124 / 255, blue: 124 / 255, alpha: 1)
        return label
    }()
    
    var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 12)
        label.text = Constants.rubleSign
        label.textAlignment = .right
        label.textColor = Constants.greenColor
        return label
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.greenColor
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.layer.cornerRadius = 15
        button.alpha = 0
        return button
    }()
    
    var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 14)
        label.text = "0.00"
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeProductRowLeft))
        swipeLeft.direction = .left
        self.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeProductRowRight))
        swipeRight.direction = .right
        self.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func swipeProductRowLeft() {
        UIView.animate(withDuration: 0.5) {
            self.deleteButton.alpha = 1
            self.productRow.frame.origin.x -= 100
            self.layoutIfNeeded()
        }
        
    }
    
    @objc func swipeProductRowRight() {
        UIView.animate(withDuration: 0.5) {
            self.deleteButton.alpha = 0
            self.productRow.frame.origin.x = 0
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        deleteButton.frame = CGRect(x: self.frame.width - 80, y: 0, width: 80, height: 115)
        deleteButton.center.y = self.frame.height / 2
        addSubview(deleteButton)
        
        productRow.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(productRow)
        
        productImage.frame = CGRect(x: 0, y: 0, width: 115, height: 115)
        productRow.addSubview(productImage)
        
        productName.frame = CGRect(x: productImage.frame.maxX + 8, y: 21,
                                   width: self.frame.width - 115 - 16, height: productName.font.pointSize)
        productRow.addSubview(productName)
        
        productSubName.frame = CGRect(x: productImage.frame.maxX + 8, y: productName.frame.maxY + 5,
                                   width: self.frame.width - 115 - 16, height: productSubName.font.pointSize)
        productRow.addSubview(productSubName)
        
        currencyLabel.frame = CGRect(x: productImage.frame.maxX + 8, y: productSubName.frame.maxY + 10,
                                   width: 10, height: currencyLabel.font.pointSize)
        productRow.addSubview(currencyLabel)
        
        productPriceLabel.frame = CGRect(x: currencyLabel.frame.maxX + 8, y: productSubName.frame.maxY + 10,
                                   width: self.frame.width - 115 - 26, height: productPriceLabel.font.pointSize)
        productRow.addSubview(productPriceLabel)
        
    }
}
