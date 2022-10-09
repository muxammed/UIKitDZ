//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

/// Константы
struct Constants {
    static let rubleSign = "\u{20BD} "
    static let description = "Description"
    static let descText = "Duis aute irure dolor in reprehenderit in voluptate velit "
    + "esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat..."
    static let greenColor = UIColor(red: 83 / 255, green: 177 / 255, blue: 117 / 255, alpha: 1)
    static let addToCart = "Добавить в корзину"
    static let cartTitle = "Корзина"
    static let searchPlaceholder = "Поиск"
    static let goToPayment = "Перейти к оплате"
    static let totalText = "Итого:"
    static let filterTitle = "Фильтры"
    static let shoesTypeText = "Стиль обуви:"
    static let yourGenderText = "Ваш пол:"
    static let writeTextPlaceholder = "Выберите"
    static let sortingText = "Сортировка по:"
    static let filterText = "Фильтровать"
    static let okeyText = "Хорошо"
}

/// Энам для перебора имен кастомного шрифта
enum CustomFont: String {
    case bold = "HKGrotesk-Bold"
    case light = "HKGrotesk-Light"
    case medium = "HKGrotesk-Medium"
    case regular = "HKGrotesk-Regular"
}

import UIKit
/// ViewController с кодом из урока 7
final class ViewController: UIViewController {
    
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
    
    let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "basket"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        return button
    }()
    
    var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 24)
        label.text = "Кросовки 1"
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var productSubNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.light.rawValue, size: 14)
        label.text = "нубук натуральный"
        label.textColor = UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
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
    
    var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 32)
        label.text = "565"
        label.textAlignment = .right
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.medium.rawValue, size: 18)
        label.text = Constants.description
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: CustomFont.light.rawValue, size: 16)
        textView.textColor = Constants.greenColor
        textView.text = Constants.descText
        return textView
    }()
    
    var setCountView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.greenColor
        view.layer.cornerRadius = 13
        return view
    }()
    
    var plusButton: UIButton = {
        let button = UIButton()
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.medium.rawValue, size: 26),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        button.setAttributedTitle(NSAttributedString(string: "+", attributes: attributes), for: .normal)
        return button
    }()
    
    var minusButton: UIButton = {
        let button = UIButton()
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.medium.rawValue, size: 26),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        button.setAttributedTitle(NSAttributedString(string: "-", attributes: attributes), for: .normal)
        return button
    }()
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.medium.rawValue, size: 20)
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var addToCartButton: UIButton = {
        let button = UIButton()
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.bold.rawValue, size: 20),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        button.setAttributedTitle(NSAttributedString(string: Constants.addToCart, attributes: attributes), for: .normal)
        button.backgroundColor = Constants.greenColor
        button.layer.cornerRadius = 34
        return button
    }()
    
    var badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.greenColor
        view.layer.cornerRadius = 10
        view.isHidden = true
        return view
    }()
    
    // MARK: - Public Properties
    var selectedProductsMap: [String: Product] = [:]
    var segmentedControll = UISegmentedControl()
    var imageView = UIImageView()
    var productsCount = 0
    var menuArray = ["фото1", "фото2", "фото3"]
    let imageArray = [UIImage(named: "krosowka3"),
                      UIImage(named: "krosowka2"),
                      UIImage(named: "krosowka1")]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViews()
    }
    
    // MARK: - Public methods
    private func setupViews() {
        self.view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = true
        
        imageView.frame = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: view.frame.height / 2)
        imageView.image = imageArray[0]
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        segmentedControll = UISegmentedControl(items: menuArray)
        segmentedControll.backgroundColor = Constants.greenColor
        let attr = [NSAttributedString.Key.font: UIFont(name: CustomFont.medium.rawValue, size: 16)]
        let attr2 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let ownBlack = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        let attr3 = [NSAttributedString.Key.foregroundColor: ownBlack]
        segmentedControll.setTitleTextAttributes(attr, for: .normal)
        segmentedControll.setTitleTextAttributes(attr2, for: .normal)
        segmentedControll.setTitleTextAttributes(attr3, for: .selected)
        segmentedControll.frame = CGRect(x: view.frame.width - 220, y: (view.frame.height / 2),
                                         width: 200, height: 30)
        segmentedControll.selectedSegmentIndex = 0
        view.addSubview(segmentedControll)
        
        setCountView.frame = CGRect(x: 20, y: (view.frame.height / 2), width: 110, height: 30)
        view.addSubview(setCountView)
        
        minusButton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        setCountView.addSubview(minusButton)
        
        plusButton.frame = CGRect(x: setCountView.frame.width - 40, y: 0, width: 40, height: 30)
        setCountView.addSubview(plusButton)
        
        countLabel.frame = CGRect(x: minusButton.frame.maxX - 10, y: 0, width: 50, height: 30)
        setCountView.addSubview(countLabel)
        
        productNameLabel.frame = CGRect(x: 20, y: segmentedControll.frame.maxY + 28,
                                   width: view.frame.width / 2, height: productNameLabel.font.pointSize)
        view.addSubview(productNameLabel)
        
        productSubNameLabel.frame = CGRect(x: 20, y: productNameLabel.frame.maxY + 4,
                                   width: view.frame.width / 2, height: productNameLabel.font.pointSize)
        view.addSubview(productSubNameLabel)
        
        productPriceLabel.frame = CGRect(x: view.frame.width - 120, y: segmentedControll.frame.maxY + 28,
                                   width: 100, height: productPriceLabel.font.pointSize)
        view.addSubview(productPriceLabel)
        
        currencyLabel.frame = CGRect(x: view.frame.width - 120, y: segmentedControll.frame.maxY + 28,
                                   width: 30, height: productPriceLabel.font.pointSize)
        view.addSubview(currencyLabel)
        
        descriptionLabel.frame = CGRect(x: 20, y: productSubNameLabel.frame.maxY + 36,
                                        width: view.frame.width - 40, height: descriptionLabel.font.pointSize)
        view.addSubview(descriptionLabel)
        
        descriptionTextView.frame = CGRect(x: 20, y: descriptionLabel.frame.maxY + 10,
                                        width: view.frame.width - 40, height: 300)
        view.addSubview(descriptionTextView)
        
        backButton.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 20, width: 51, height: 51)
        view.addSubview(backButton)
        
        cartButton.frame = CGRect(x: view.frame.width - 71, y: view.safeAreaInsets.top + 20, width: 51, height: 51)
        view.addSubview(cartButton)
        
        addToCartButton.frame = CGRect(x: 20, y: view.frame.height - 108, width: view.frame.width - 40, height: 68)
        view.addSubview(addToCartButton)
        
        badgeView.frame = CGRect(origin: CGPoint(x: cartButton.frame.maxX, y: cartButton.frame.minY),
                                 size: CGSize(width: 20, height: 20))
        badgeView.center = CGPoint(x: cartButton.frame.maxX, y: cartButton.frame.minY)
        view.addSubview(badgeView)
        segmentedControll.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
        
        plusButton.addTarget(self, action: #selector(addOneAction), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusOneAction), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(gotoCartAction), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
    }
    
    @objc func addOneAction() {
        productsCount += 1
        badgeView.isHidden = false
        countLabel.text = "\(productsCount)"
        let product = Product(name: productNameLabel.text ?? "",
                              subName: productSubNameLabel.text ?? "",
                              price: CGFloat(Double(productPriceLabel.text ?? "0") ?? 0.00),
                              count: productsCount,
                              image: imageArray[0] ?? UIImage())
        selectedProductsMap[product.name] = product
    }
    
    @objc func addToCartAction() {
        guard let selectedProductCount = selectedProductsMap[productNameLabel.text ?? ""]?.count else {
            showAlert(title: "Упс", message: "Количество выбранной продукции равно нулю, нечего добавлять")
            return }
        if selectedProductCount == 0 {
            showAlert(title: "Упс", message: "Количество выбранной продукции равно нулю, нечего добавлять")
        } else {
            showAlert(title: "Успех", message: "Продукция добавлена в корзину")
        }
    }
    
    @objc func minusOneAction() {
        if productsCount >= 1 {
            productsCount -= 1
            countLabel.text = "\(productsCount)"
            let product = Product(name: productNameLabel.text ?? "",
                                  subName: productSubNameLabel.text ?? "",
                                  price: CGFloat(Double(productPriceLabel.text ?? "0") ?? 0.00),
                                  count: productsCount, image: imageArray[0] ?? UIImage())
            selectedProductsMap[product.name] = product
        }
        badgeView.isHidden = productsCount == 0 ? true : false
        
    }
    
    @objc func gotoCartAction() {
        let cartViewController = CartViewController()
        cartViewController.productsInCartMap = selectedProductsMap
        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    @objc func selectedValue(target: UISegmentedControl) {
        if target == segmentedControll {
            let segmentIndex = target.selectedSegmentIndex
            self.imageView.image = imageArray[segmentIndex]
            let pr = target.titleForSegment(at: segmentIndex)
        }
    }
}

/// расширения для показа алерата
extension ViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: Constants.okeyText, style: .default, handler: nil)
        alertController.addAction(okeyAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
