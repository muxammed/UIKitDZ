//
//  SearchView.swift
//  UIKitDZ
//
//  Created by muxammed on 09.10.2022.
//

import UIKit

/// кастомный поиск вьюв выведен в отдельный файл для переиспользования
final class SearchView: UIView {
    
    let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.placeholder = "Поиск"
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.medium.rawValue, size: 16)]
        textField.attributedPlaceholder = NSAttributedString(string: Constants.searchPlaceholder,
                                                             attributes: attributes)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchIcon)
        addSubview(searchTextField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.backgroundColor = UIColor(red: 242 / 255, green: 243 / 255, blue: 242 / 255, alpha: 1)
        self.layer.cornerRadius = 15
        
        searchIcon.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        searchIcon.center.y = self.frame.height / 2
        
        searchTextField.frame = CGRect(x: searchIcon.frame.maxX + 18, y: 0, width: self.frame.width - 78, height: 44)
        searchTextField.center.y = self.frame.height / 2
        
    }
    
}
