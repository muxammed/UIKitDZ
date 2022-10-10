//
//  ViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import CoreLocation
import UIKit

/// ViewController задание к 8му уроку потринироваться с UIActivityController шарить
class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var shareImage: UIImageView!
    @IBOutlet weak var shareTextTextField: UITextField!
    @IBOutlet weak var shareLocationTextField: UITextField!
    @IBOutlet weak var sharePickerView: UIPickerView!
    
    // MARK: - Public Properties
    var imagePicker = UIImagePickerController()
    var pickerItems = ["Share Image", "Share Text", "Share Location"]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - IBAction
    @IBAction func selectImageAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private Methods
    fileprivate func configure() {
        self.view.backgroundColor = .white
        sharePickerView.delegate = self
        
        shareLocationTextField.text = "54.5308; 36.2699"
    }
}

/// UIPickerViewDelegate, UIPickerViewDataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var shareItems: Any = []
        
        switch row {
        case 0:
            shareItems = [shareImage.image]
        case 1:
            shareItems = [shareTextTextField.text ?? ""]
        case 2:
            let parts = shareLocationTextField.text?.split(separator: ";")
            let location = CLLocation(latitude: CLLocationDegrees(Double(parts?[0] ?? "0") ?? 0),
                                      longitude: CLLocationDegrees(Double(parts?[1] ?? "0") ?? 0))
            let urlString = "https://maps.apple.com?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"

                    if let url = NSURL(string: urlString) {
                        shareItems = [url]
                    }
        default:
            break
        }
        
        guard let shareitems = shareItems as? [Any] else { return }
        
        let activityController = UIActivityViewController(activityItems: shareitems,
                                                          applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}

/// UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        shareImage.image = image
        self.dismiss(animated: true, completion: nil)
    }
}
