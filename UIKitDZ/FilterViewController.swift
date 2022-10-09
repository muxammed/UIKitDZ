//
//  FilterViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 09.10.2022.
//

import UIKit

/// энам стилей обуви для удобного выбора
enum ShoesStyles: String {
    case teenager = "Молодежный"
    case classic = "Классика"
    case childred = "Детские"
    case nomatter = "Без разницы"
}

/// экран фильтрации и сортироваки продукции
final class FilterViewController: UIViewController {
    
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
        label.text = Constants.filterTitle
        label.textAlignment = .center
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var shoesTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.light.rawValue, size: 16)
        label.textColor = UIColor(red: 124 / 255, green: 124 / 255, blue: 124 / 255, alpha: 1)
        label.text = Constants.shoesTypeText
        return label
    }()
    
    var shoesTypeValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.bold.rawValue, size: 16)
        label.text = Constants.shoesTypeText
        label.textAlignment = .right
        label.textColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 1)
        return label
    }()
    
    var shoesTypeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = Constants.greenColor
        slider.minimumValue = 0
        slider.maximumValue = 3
        slider.value = 0
        return slider
    }()
    
    var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.light.rawValue, size: 16)
        label.textColor = UIColor(red: 124 / 255, green: 124 / 255, blue: 124 / 255, alpha: 1)
        label.text = Constants.yourGenderText
        return label
    }()
    
    let genderBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 242 / 255, green: 243 / 255, blue: 242 / 255, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    var yourGenderTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.medium.rawValue, size: 16)]
        textField.attributedPlaceholder = NSAttributedString(string: Constants.writeTextPlaceholder,
                                                             attributes: attributes)
        return textField
    }()
    
    var sortingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: CustomFont.light.rawValue, size: 16)
        label.textColor = UIColor(red: 124 / 255, green: 124 / 255, blue: 124 / 255, alpha: 1)
        label.text = Constants.sortingText
        return label
    }()
    
    let sortingBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 242 / 255, green: 243 / 255, blue: 242 / 255, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    var sortingTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.medium.rawValue, size: 16)]
        textField.attributedPlaceholder = NSAttributedString(string: Constants.writeTextPlaceholder,
                                                             attributes: attributes)
        return textField
    }()
    
    var filterButton: UIButton = {
        let button = UIButton()
        let attributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.bold.rawValue, size: 20),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        button.setAttributedTitle(NSAttributedString(string: Constants.filterText, attributes: attributes),
                                  for: .normal)
        button.backgroundColor = Constants.greenColor
        button.layer.cornerRadius = 34
        return button
    }()
    
    var genderPickerView = ToolbarPickerView(frame: .zero)
    var sortingPickerView = ToolbarPickerView(frame: .zero)
    
    // MARK: - Public Properties
    let step: Float = 1
    let sorting = ["Цена по убыванию", "Цена по увеличению", "Сначала новые", "Сначала популярные"]
    let genders = ["Мужской", "Женский"]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureFrames()
    }
    
    // MARK: - Public methods
    func configureFrames() {
        
        backButton.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 20, width: 51, height: 51)
        view.addSubview(backButton)
        
        shoesTypeLabel.frame = CGRect(x: 20, y: backButton.frame.maxY + 30,
                                      width: (view.frame.width - 40) / 2, height: shoesTypeLabel.font.pointSize)
        view.addSubview(shoesTypeLabel)
        
        shoesTypeValueLabel.frame = CGRect(x: view.frame.width / 2, y: backButton.frame.maxY + 30,
                                           width: (view.frame.width - 40) / 2,
                                           height: shoesTypeValueLabel.font.pointSize)
        view.addSubview(shoesTypeValueLabel)
        
        shoesTypeSlider.frame = CGRect(x: 20, y: shoesTypeLabel.frame.maxY + 10,
                                       width: view.frame.width - 40, height: 30)
        view.addSubview(shoesTypeSlider)
        
        genderLabel.frame = CGRect(x: 20, y: shoesTypeSlider.frame.maxY + 30,
                                   width: view.frame.width - 40, height: genderLabel.font.pointSize)
        view.addSubview(genderLabel)
        
        genderBackView.frame = CGRect(x: 20, y: genderLabel.frame.maxY + 5, width: view.frame.width - 40, height: 51)
        view.addSubview(genderBackView)
        
        yourGenderTextField.frame = CGRect(x: 20, y: 0, width: genderBackView.frame.width - 40, height: 30)
        yourGenderTextField.center.y = genderBackView.frame.height / 2
        genderBackView.addSubview(yourGenderTextField)
        yourGenderTextField.inputView = genderPickerView
        yourGenderTextField.inputAccessoryView = genderPickerView.toolbar
        
        sortingLabel.frame = CGRect(x: 20, y: genderBackView.frame.maxY + 30,
                                   width: view.frame.width - 40, height: sortingLabel.font.pointSize)
        view.addSubview(sortingLabel)
        
        sortingBackView.frame = CGRect(x: 20, y: sortingLabel.frame.maxY + 5, width: view.frame.width - 40, height: 51)
        view.addSubview(sortingBackView)
        
        sortingTextField.frame = CGRect(x: 20, y: 0, width: sortingBackView.frame.width - 40, height: 30)
        sortingTextField.center.y = sortingBackView.frame.height / 2
        sortingBackView.addSubview(sortingTextField)
        sortingTextField.inputView = sortingPickerView
        sortingTextField.inputAccessoryView = sortingPickerView.toolbar
        
        filterButton.frame = CGRect(x: 20, y: view.frame.height - 108, width: view.frame.width - 40, height: 68)
        view.addSubview(filterButton)
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 142, height: 44)
        titleLabel.center.y = backButton.center.y
        titleLabel.center.x = view.center.x
        view.addSubview(titleLabel)
        
        backButton.addTarget(self, action: #selector(goToBackAction), for: .touchUpInside)
        shoesTypeSlider.addTarget(self, action: #selector(sliderSlidedAction(_:)), for: .valueChanged)
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        
        genderPickerView.delegate = self
        genderPickerView.toolbarDelegate = self
        sortingPickerView.delegate = self
        sortingPickerView.toolbarDelegate = self
        genderPickerView.backgroundColor = .white
        sortingPickerView.backgroundColor = .white
    }
    
    @objc func goToBackAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func filterButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sliderSlidedAction(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        switch roundedValue {
        case 0:
            shoesTypeValueLabel.text = ShoesStyles.teenager.rawValue
        case 1:
            shoesTypeValueLabel.text = ShoesStyles.classic.rawValue
        case 2:
            shoesTypeValueLabel.text = ShoesStyles.childred.rawValue
        case 3:
            shoesTypeValueLabel.text = ShoesStyles.nomatter.rawValue
        default:
            break
        }
    }
}

/// UIPickerViewDelegate, UIPickerViewDataSource
extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView == genderPickerView {
            count = genders.count
        } else {
            count = sorting.count
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.font = UIFont(name: CustomFont.bold.rawValue, size: 17)
        pickerLabel.textColor = UIColor.black
        pickerLabel.textAlignment = .center
        pickerLabel.text = pickerView == genderPickerView ? genders[row] : sorting[row]
        return pickerLabel
    }
}

/// ToolbarPickerViewDelegate
extension FilterViewController: ToolbarPickerViewDelegate {
    
    func didTapDone(_ picker: ToolbarPickerView) {
        if picker == genderPickerView {
            let row = genderPickerView.selectedRow(inComponent: 0)
            yourGenderTextField.text = genders[row]
            yourGenderTextField.resignFirstResponder()
        } else {
            let row = sortingPickerView.selectedRow(inComponent: 0)
            sortingTextField.text = sorting[row]
            sortingTextField.resignFirstResponder()
        }
    }
    
    func didTapCancel(_ picker: ToolbarPickerView) {
        if picker == genderPickerView {
            yourGenderTextField.text = nil
            yourGenderTextField.resignFirstResponder()
        } else {
            sortingTextField.text = nil
            sortingTextField.resignFirstResponder()
        }
    }
}
