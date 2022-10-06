//
//  AddPersonViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 26.09.2022.
//

import UIKit

/// protocol used for sending entered Person data back
protocol PersonEnterDelegate: AnyObject {
    func newPersonEntered(person: Person)
}
/// AddPersonViewController - модальный VC для добавление нового Person
final class AddPersonViewController: UIViewController {
    
    // MARK: - Visual Components
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    let addPersonButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Добавить",
                                  attributes: [.font: UIFont.roundedMplus(.bold, size: 17),
                                  .foregroundColor: UIColor.systemBlue]),
                                  for: .normal)
        
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Отмена",
                                  attributes: [.font: UIFont.roundedMplus(.bold, size: 17),
                                  .foregroundColor: UIColor.systemBlue]),
                                  for: .normal)
        
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let changeImageButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Изменить фото",
                                  attributes: [.font: UIFont.roundedMplus(.bold, size: 17),
                                  .foregroundColor: UIColor.systemBlue]),
                                  for: .normal)
        return button
    }()
    
    let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .lightGray
        imageView.layer.cornerRadius = 70
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let nameInputView: InputView = {
        let nameIV = InputView(frame: .zero,
                               hintText: "Имя",
                               hintColor: Constants.pinkColor,
                               inputTextFieldPlaceholder: "Введите имя",
                               inputTextFieldTintColor: Constants.inactiveColor,
                               isPasswordTextField: false,
                               pickerView: nil,
                               textFieldTag: 0)
        return nameIV
    }()
    
    var dateInputView = InputView()
    var ageInputView = InputView()
    var genderInputView = InputView()
    var instagramInputView = InputView()
    
    // MARK: - Public Properties
    weak var delegate: PersonEnterDelegate?
    var personImage = UIImage(systemName: "person.crop.circle.fill")
    var picker = UIPickerView()
    let genders = [Gender.male, Gender.female]
    let min = 1
    let max = 100
    var ages: [Int] = Array(1...100)
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()

    // MARK: - UIViewController(*)
    fileprivate func configure() {
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = Constants.inactiveColor
        dateInputView.inputTextField.delegate = self
        ageInputView.inputTextField.delegate = self
        genderInputView.inputTextField.delegate = self
        instagramInputView.inputTextField.delegate = self
        
        ages = Array(1...100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupViews()
        configure()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViews()
    }
    // MARK: - Public methods
    func addViews() {
        
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        dateInputView = InputView(frame: .zero,
                     hintText: "Дата",
                     hintColor: Constants.pinkColor,
                     inputTextFieldPlaceholder: "Введите дату",
                     inputTextFieldTintColor: Constants.inactiveColor,
                     isPasswordTextField: false,
                     pickerView: nil,
                     textFieldTag: 3)
        
        ageInputView = InputView(frame: .zero,
                     hintText: "Возраст",
                     hintColor: Constants.pinkColor,
                     inputTextFieldPlaceholder: "Добавить",
                     inputTextFieldTintColor: Constants.inactiveColor,
                     isPasswordTextField: false,
                     pickerView: picker,
                     textFieldTag: 2)
        
        genderInputView = InputView(frame: .zero,
                                    hintText: "Пол",
                                    hintColor: Constants.pinkColor,
                                    inputTextFieldPlaceholder: "Добавить",
                                    inputTextFieldTintColor: Constants.inactiveColor,
                                    isPasswordTextField: false,
                                    pickerView: picker,
                                    textFieldTag: 1)
        instagramInputView = InputView(frame: .zero,
                                    hintText: "Instagram",
                                    hintColor: Constants.pinkColor,
                                    inputTextFieldPlaceholder: "Добавить",
                                    inputTextFieldTintColor: Constants.inactiveColor,
                                    isPasswordTextField: false,
                                    pickerView: nil,
                                    textFieldTag: 4)
        
        view.addSubview(cancelButton)
        view.addSubview(addPersonButton)
        view.addSubview(personImageView)
        view.addSubview(changeImageButton)
        view.addSubview(nameInputView)
        view.addSubview(dateInputView)
        view.addSubview(ageInputView)
        view.addSubview(genderInputView)
        view.addSubview(instagramInputView)
    }
    @objc func doneClickAction() {
        
        UIView.animate(withDuration: 1) {
            self.picker.isHidden = true
        }
    }
    
    @objc func cancelClickAction() {
        view.endEditing(true)
        UIView.animate(withDuration: 1) {
            self.picker.isHidden = true
        }
    }
    func setupViews() {
        cancelButton.frame = CGRect(x: 20, y: 20, width: view.frame.width / 2 - 20, height: 20)
        addPersonButton.frame = CGRect(x: view.frame.width / 2, y: 20, width: view.frame.width / 2 - 20, height: 20)
        personImageView.frame = CGRect(x: 0, y: cancelButton.frame.maxY + 20, width: 140, height: 140)
        personImageView.center.x = view.center.x
        changeImageButton.frame = CGRect(x: 0, y: personImageView.frame.maxY + 10, width: view.frame.width, height: 20)
        changeImageButton.addTarget(self, action: #selector(changeImageButtonAction), for: .touchUpInside)
        nameInputView.frame = CGRect(x: 20, y: changeImageButton.frame.maxY + 20,
                                     width: view.frame.width - 40, height: 80)
        dateInputView.frame = CGRect(x: 20, y: nameInputView.frame.maxY,
                                     width: view.frame.width - 40, height: 80)
        ageInputView.frame = CGRect(x: 20, y: dateInputView.frame.maxY,
                                     width: view.frame.width - 40, height: 80)
        genderInputView.frame = CGRect(x: 20, y: ageInputView.frame.maxY,
                                       width: view.frame.width - 40, height: 80)
        instagramInputView.frame = CGRect(x: 20, y: genderInputView.frame.maxY,
                                       width: view.frame.width - 40, height: 80)
        
        addPersonButton.addTarget(self, action: #selector(addPersonButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(handleDatePickerAction(sender:)), for: .valueChanged)
    }
    @objc func handleDatePickerAction(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateInputView.inputTextField.text = dateFormatter.string(from: sender.date)
     }
    
    @objc func changeImageButtonAction() {
        let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func cancelButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func addPersonButtonAction() {
        
        if let image = personImage {
            let person = Person(name: nameInputView.inputTextField.text ?? "",
                                personImage: image,
                                birthDate: dateFormatter.date(from: dateInputView.inputTextField.text ?? "") ?? Date(),
                                gender: genderInputView.inputTextField.text ?? "",
                                instagram: instagramInputView.inputTextField.text ?? "")
            delegate?.newPersonEntered(person: person)
        } else {
            guard let noImage = UIImage(systemName: "") else { return }
            let person = Person(name: nameInputView.inputTextField.text ?? "",
                                personImage: noImage,
                                birthDate: dateFormatter.date(from: dateInputView.inputTextField.text ?? "") ?? Date(),
                                gender: genderInputView.inputTextField.text ?? "",
                                instagram: instagramInputView.inputTextField.text ?? "")
            delegate?.newPersonEntered(person: person)
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddPersonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo
                               info: [UIImagePickerController.InfoKey: Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        personImage = tempImage
        personImageView.image = tempImage
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension AddPersonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowsCount = 0
        switch pickerView.tag {
        case 1:
            rowsCount = genders.count
        case 2:
            rowsCount = ages.count
        default:
            break
        }
        return rowsCount
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        var returnString = ""
        switch pickerView.tag {
        case 1:
            returnString = "\(self.genders[row])"
        case 2:
            returnString = "\(self.ages[row])"
        default:
            break
        }
        
        return NSAttributedString(string: returnString, attributes: [.foregroundColor: UIColor.black])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            genderInputView.inputTextField.text = "\(self.genders[row])"
            genderInputView.inputTextField.resignFirstResponder()
        case 2:
            ageInputView.inputTextField.text = "\(self.ages[row])"
            ageInputView.inputTextField.resignFirstResponder()
        default:
            break
        }
        
    }
}

// MARK: - UITextFieldDelegate
extension AddPersonViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 3:
            dateInputView.inputTextField.inputView = datePicker // date picker
        case 4:
            showAlertAction()
        default:
            break
        }
        picker.tag = textField.tag
        return true
    }
    
    @objc func showAlertAction() {
        var instagramString = ""
        let alertController = UIAlertController(title: "",
                                                message: "Введите username Instagram",
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Например: yashalava2019"
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            instagramString = alertController.textFields?.first?.text ?? ""
            self.instagramInputView.inputTextField.text = instagramString
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
