//
//  FirstTabController.swift
//  UIKitDZ
//
//  Created by muxammed on 17.10.2022.
//

import UIKit

/// FirstTabController первый экран с текстовым лейблом и прочими регуляторыми
final class FirstTabController: UIViewController {
    
    // MARK: - Visual Components
    let testLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let fontSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 60
        return slider
    }()
    
    let addShadowSwitcher = UISwitch()
    let colorPicker = UIPickerView()
    let linesPicker = UIPickerView()
    
    // MARK: - Public Properties
    let colors = [UIColor.red, UIColor.green, UIColor.gray, UIColor.yellow, UIColor.systemIndigo, UIColor.orange]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public methods
    @objc func addShadowAction(_ switcher: UISwitch) {
        if switcher.isOn {
            testLabel.layer.shadowColor = UIColor.black.cgColor
            testLabel.layer.shadowRadius = 3.0
            testLabel.layer.shadowOpacity = 1.0
            testLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
            testLabel.layer.masksToBounds = false
        } else {
            testLabel.layer.shadowOpacity = 0.0
        }
    }
    
    @objc func slideFontAction(_ slider: UISlider) {
        testLabel.font = UIFont.systemFont(ofSize: CGFloat(slider.value), weight: .regular)
        testLabel.frame.size.height = testLabel.font.pointSize
    }
    
    @objc func addTextToLabel() {
        let alertController = UIAlertController(title: "", message: Constants.alertText, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { textField  -> Void in
            textField.placeholder = Constants.placeholderText
        })
        let addAction = UIAlertAction(title: Constants.okeyText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let textField = alertController.textFields?[0] {
                self.testLabel.text = textField.text ?? ""
            }
        }
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func configure() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.tabOnaName
        
        let navBarItem = UIBarButtonItem(image: UIImage(systemName: Constants.plusIcon),
                                         style: .plain, target: self, action: #selector(addTextToLabel))
        navigationItem.rightBarButtonItems = [navBarItem]
        
        view.addSubview(testLabel)
        testLabel.frame = CGRect(x: 20, y: 200, width: view.frame.width - 40, height: testLabel.font.pointSize)
        view.addSubview(fontSlider)
        fontSlider.value = Float(testLabel.font.pointSize)
        fontSlider.frame = CGRect(x: 20, y: view.frame.height - 220, width: view.frame.width - 40, height: 10)
        fontSlider.addTarget(self, action: #selector(slideFontAction(_:)), for: .valueChanged)
        colorPicker.delegate = self
        linesPicker.delegate = self
        view.addSubview(colorPicker)
        view.addSubview(linesPicker)
        colorPicker.frame = CGRect(x: 10, y: 0, width: (view.frame.width - 30) / 2,
                                   height: (view.frame.width - 30) / 2 )
        linesPicker.frame = CGRect(x: 10 + ((view.frame.width - 30) / 2), y: 0,
                                   width: (view.frame.width - 30) / 2, height: (view.frame.width - 30) / 2 )
        colorPicker.center.y = view.center.y
        linesPicker.center.y = view.center.y
        
        view.addSubview(addShadowSwitcher)
        addShadowSwitcher.frame = CGRect(x: 0, y: fontSlider.frame.minY - 80, width: 100, height: 50)
        addShadowSwitcher.center.x = view.center.x
        addShadowSwitcher.addTarget(self, action: #selector(addShadowAction), for: .valueChanged)
    }
}

/// UIPickerViewDelegate, UIPickerViewDataSource
extension FirstTabController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == colorPicker {
            return colors.count
        }
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        var attrs = [NSAttributedString.Key.foregroundColor: UIColor.black]
        if pickerView == colorPicker {
            attrs = [NSAttributedString.Key.backgroundColor: colors[row]]
            return NSAttributedString(string: "   \(colors[row].accessibilityName)   ", attributes: attrs)
        }
        return NSAttributedString(string: "\(row)", attributes: attrs)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == colorPicker {
            testLabel.textColor = colors[row]
        } else {
            testLabel.numberOfLines = row
            testLabel.frame.size.height = (testLabel.font.pointSize * 2) * CGFloat(row)
        }
    }
}
