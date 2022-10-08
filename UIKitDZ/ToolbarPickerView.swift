//
//  ToolbarPickerView.swift
//  UIKitDZ
//
//  Created by muxammed on 07.10.2022.
//

import Foundation
import UIKit

/// ToolbarPickerViewDelegate
protocol ToolbarPickerViewDelegate: AnyObject {
    func didTapDone()
    func didTapCancel()
}

/// кастомный pickerview c верхней планкой с кнопками дан и отбой
final class ToolbarPickerView: UIPickerView {
    
    var toolbar: UIToolbar?
    weak var toolbarDelegate: ToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configure() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self,
                                           action: #selector(cancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func doneTapped() {
        toolbarDelegate?.didTapDone()
    }

    @objc func cancelTapped() {
        toolbarDelegate?.didTapCancel()
    }
}
