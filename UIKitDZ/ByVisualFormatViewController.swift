//
//  ByVisualFormatViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 17.10.2022.
//

import UIKit
/// ByVisualFormatViewController - экран верстки визуал форматом наследовался ByCodeViewController что не писать код а переиспользовать и переопределить функцию конфигур
final class ByVisualFormatViewController: ByCodeViewController {
    
    override func configure() {
        view.backgroundColor = .white
        
        view.addSubview(backView)
        backView.addSubview(redView)
        backView.addSubview(yellowView)
        backView.addSubview(greenView)
        
        addCons()
        
    }
    
    private func addCons() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-(<=1)-[v1]",
                                                              options: .alignAllCenterX, metrics: nil,
                                                               views: ["v0": view as Any, "v1": backView]))
        
        let safeInsetTop = self.view.safeAreaInsets.top + 10
        let safeInsetBottom = self.view.safeAreaInsets.bottom + 10
        let verticalConstraints = String(format: "V:|-%f-[v0]-%f-|", safeInsetTop, safeInsetBottom)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalConstraints,
                                                           options: NSLayoutConstraint.FormatOptions(),
                                                           metrics: nil, views: ["v0": backView]))
        let verticalCons = "V:|-10-[v0(==v1)]-10-[v1(==v2)]-10-[v2]-10-|"
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalCons,
                                                           options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                                                           views: ["v0": redView, "v1": yellowView, "v2": greenView]))
        
        let horConstraints = String(format: "H:|-10-[v0]-10-|", redView.frame.height)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horConstraints,
                                                           options: NSLayoutConstraint.FormatOptions(),
                                                           metrics: nil, views: ["v0": redView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|",
                                                           options: NSLayoutConstraint.FormatOptions(),
                                                           metrics: nil, views: ["v0": yellowView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|",
                                                           options: NSLayoutConstraint.FormatOptions(),
                                                           metrics: nil, views: ["v0": greenView]))
        yellowView.widthAnchor.constraint(equalTo: yellowView.heightAnchor).isActive = true
    
    }

}
