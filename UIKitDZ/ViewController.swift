//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit

/// Константы для проекта
struct Constants {
    static let dummyText = "Lorem ipsum dolor sit amet,"
    + " consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. "
    + "Cum sociis natoque penatibus et  magnis dis parturient montes, nascetur ridiculus mus. "
    + "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. "
    + "Nulla consequat massa quis enim. Donec pede justo, fringilla vel, "
    + "aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, "
    + "venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. "
    + "Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. "
    + "Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, "
    + "consequat vitae, eleifend ac, enim. Aliquam lorem ante, "
    + "dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus "
    + " varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. "
    + "Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. "
    + "Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, "
    + "sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, "
    + "luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt"
    + " tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. "
    + "Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. "
    + "Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. "
    + "Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"
}

/// ViewController с TextView и прочими элементами настройки
class ViewController: UIViewController {

    // MARK: - Visual Components
    var myTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        textView.text = Constants.dummyText
        textView.textColor = .black
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    var textSizeSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 10
        slider.value = 17
        slider.tintColor = .orange
        return slider
    }()
    
    var smallSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .orange
        return label
    }()
    
    var bigSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .orange
        return label
    }()
    
    var blackColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var greenColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var blueColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var grayColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var thinnerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Thinner", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    var bolderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bolder", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    var shareTextButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.tintColor = .systemIndigo
        button.layer.cornerRadius = 10
        return button
    }()
    
    var lightDarkSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.tintColor = .darkGray
        return switcher
    }()
    
    var showFontPickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать шрифт", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        return button
    }()
    
    var fontPickerView = ToolbarPickerView(frame: .zero)
    
    var hiddenTextField = UITextField()
    
    // MARK: - Public Properties
    let weights = [UIFont.Weight.ultraLight, UIFont.Weight.light,
                   UIFont.Weight.thin, UIFont.Weight.regular, UIFont.Weight.medium,
                   UIFont.Weight.bold, UIFont.Weight.black, UIFont.Weight.heavy]
    var curWeight = 2
    var fontsListArray: [String] = []
    
    // MARK: - UIViewController(*)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        loadFontsNames()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureFrames()
    }

    // MARK: - Public methods
    @objc func makeThinner() {
        if curWeight > 1 {
            curWeight -= 1
            myTextView.font = UIFont.systemFont(ofSize: myTextView.font?.pointSize ?? 17, weight: weights[curWeight])
        }
    }
    
    @objc func shareButtonAction() {
        let activityViewController = UIActivityViewController(activityItems: [Constants.dummyText],
                                                              applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func darkLightSwitcherAction(_ sender: UISwitch) {
        overrideUserInterfaceStyle = sender.isOn ? .dark : .light
    }
    
    @objc func makeBolder() {
        if curWeight < (weights.count - 1) {
            curWeight += 1
            myTextView.font = UIFont.systemFont(ofSize: myTextView.font?.pointSize ?? 17, weight: weights[curWeight])
        }
    }
    
    @objc func setBlackColor(_ sender: UIView) {
        myTextView.textColor = .black
    }
    
    @objc func setGreenColor(_ sender: UIView) {
        myTextView.textColor = .green
    }
    
    @objc func setBlueColor(_ sender: UIView) {
        myTextView.textColor = .blue
    }
    
    @objc func setGrayColor(_ sender: UIView) {
        myTextView.textColor = .gray
    }
    
    @objc func sliderSlidedAction(_ sender: UISlider) {
        myTextView.font = UIFont(name: myTextView.font?.fontName ?? "Helvetica", size: CGFloat(sender.value))
    }
    
    @objc func showFontPickerAction(_ sender: UIButton) {
        hiddenTextField.becomeFirstResponder()
    }

    // MARK: - Private Methods
    fileprivate func configure() {
        
        view.addSubview(myTextView)
        view.addSubview(smallSizeLabel)
        view.addSubview(textSizeSlider)
        view.addSubview(bigSizeLabel)
        view.addSubview(blackColorView)
        view.addSubview(greenColorView)
        view.addSubview(blueColorView)
        view.addSubview(grayColorView)
        view.addSubview(thinnerButton)
        view.addSubview(bolderButton)
        view.addSubview(shareTextButton)
        view.addSubview(showFontPickerButton)
        view.addSubview(hiddenTextField)
        view.addSubview(lightDarkSwitcher)
        
        fontPickerView.delegate = self
        fontPickerView.dataSource = self
        fontPickerView.toolbarDelegate = self
        fontPickerView.backgroundColor = .white
        
        hiddenTextField.isHidden = true
        hiddenTextField.inputView = fontPickerView
        hiddenTextField.inputAccessoryView = fontPickerView.toolbar
        
        textSizeSlider.addTarget(self, action: #selector(sliderSlidedAction(_:)), for: .valueChanged)
        blackColorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setBlackColor(_:))))
        blueColorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setBlueColor(_:))))
        greenColorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setGreenColor(_:))))
        grayColorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setGrayColor(_:))))
        
        thinnerButton.addTarget(self, action: #selector(makeThinner), for: .touchUpInside)
        bolderButton.addTarget(self, action: #selector(makeBolder), for: .touchUpInside)
        shareTextButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        showFontPickerButton.addTarget(self, action: #selector(showFontPickerAction), for: .touchUpInside)
        lightDarkSwitcher.addTarget(self, action: #selector(darkLightSwitcherAction), for: .valueChanged)
    }
    
    fileprivate func configureFrames() {
        myTextView.frame = CGRect(x: 0,
                                  y: self.view.safeAreaInsets.top,
                                  width: self.view.bounds.width, height: self.view.bounds.height / 2)
        textSizeSlider.frame = CGRect(x: 0, y: myTextView.frame.maxY + 20,
                                      width: view.frame.width / 2, height: textSizeSlider.frame.height)
        textSizeSlider.center.x = view.center.x
        smallSizeLabel.frame = CGRect(x: textSizeSlider.frame.minX - 20, y: 0, width: 20, height: 20)
        bigSizeLabel.frame = CGRect(x: textSizeSlider.frame.maxX + 20, y: 0, width: 20, height: 20)
        smallSizeLabel.center.y = textSizeSlider.center.y
        bigSizeLabel.center.y = textSizeSlider.center.y
        
        blackColorView.frame = CGRect(x: 0, y: textSizeSlider.frame.maxY + 50,
                                      width: (view.frame.width / 4) - 30, height: (view.frame.width / 4) - 30)
        blackColorView.layer.cornerRadius = blackColorView.frame.width / 2
        blackColorView.center.x = (view.frame.width / 4) / 2
        
        greenColorView.frame = CGRect(x: 0, y: textSizeSlider.frame.maxY + 50,
                                      width: (view.frame.width / 4) - 30, height: (view.frame.width / 4) - 30)
        greenColorView.layer.cornerRadius = blackColorView.frame.width / 2
        greenColorView.center.x = ((view.frame.width / 4) / 2) * 3
        
        blueColorView.frame = CGRect(x: 0, y: textSizeSlider.frame.maxY + 50,
                                     width: (view.frame.width / 4) - 30, height: (view.frame.width / 4) - 30)
        blueColorView.layer.cornerRadius = blackColorView.frame.width / 2
        blueColorView.center.x = ((view.frame.width / 4) / 2) * 5
        
        grayColorView.frame = CGRect(x: 0, y: textSizeSlider.frame.maxY + 50,
                                     width: (view.frame.width / 4) - 30, height: (view.frame.width / 4) - 30)
        grayColorView.layer.cornerRadius = blackColorView.frame.width / 2
        grayColorView.center.x = ((view.frame.width / 4) / 2) * 7
        
        thinnerButton.frame = CGRect(x: 10, y: blackColorView.frame.maxY + 50,
                                     width: (view.frame.width / 2) - 20, height: 44)
        bolderButton.frame = CGRect(x: view.frame.width / 2, y: blackColorView.frame.maxY + 50,
                                    width: (view.frame.width / 2) - 20, height: 44)
        shareTextButton.frame = CGRect(x: 10, y: bolderButton.frame.maxY + 10, width: 40, height: 40)
        
        showFontPickerButton.frame = CGRect(x: shareTextButton.frame.maxX + 10, y: 0, width: 245, height: 44)
        showFontPickerButton.frame.origin.y = shareTextButton.frame.origin.y
        
        hiddenTextField.frame = CGRect(x: 0, y: view.frame.maxY - 50, width: 200, height: 44)
        
        lightDarkSwitcher.frame = CGRect(x: view.frame.width - 50 - 20, y: 0, width: 50, height: 44)
        lightDarkSwitcher.center.y = showFontPickerButton.center.y
    }
    
    private func loadFontsNames() {
        for fontFamilyName in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName) {
                fontsListArray.append(fontName)
            }
        }
    }
}

/// UIPickerViewDelegate, UIPickerViewDataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontsListArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.font = UIFont(name: fontsListArray[row], size: 17)
        pickerLabel.textColor = UIColor.black
        pickerLabel.textAlignment = .center
        pickerLabel.text = fontsListArray[row]
        return pickerLabel
    }
}

/// ToolbarPickerViewDelegate
extension ViewController: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = fontPickerView.selectedRow(inComponent: 0)
        fontPickerView.selectRow(row, inComponent: 0, animated: false)
        myTextView.font = UIFont(name: fontsListArray[row], size: myTextView.font?.pointSize ?? 17)
        hiddenTextField.resignFirstResponder()
    }

    func didTapCancel() {
        hiddenTextField.text = nil
        hiddenTextField.resignFirstResponder()
    }
}
