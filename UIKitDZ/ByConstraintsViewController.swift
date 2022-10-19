//
//  ByConstraintsViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 17.10.2022.
//

import UIKit

/// ByConstraintsViewController экран верстки констраинтами наследовался ByCodeViewController что не писать код а переиспользовать и переопределить функцию конфигур
final class ByConstraintsViewController: ByCodeViewController {
    
    override func configure() {
        view.backgroundColor = .white
        
        view.addSubview(backView)
        backView.addSubview(redView)
        backView.addSubview(yellowView)
        backView.addSubview(greenView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: backView, attribute: .centerX, relatedBy: .equal,
                                    toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: backView, attribute: .top, relatedBy: .equal,
                                    toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: backView, attribute: .bottom, relatedBy: .equal,
                                    toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: redView, attribute: .top, relatedBy: .equal,
                                    toItem: backView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: redView, attribute: .leading, relatedBy: .equal,
                                    toItem: backView, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: redView, attribute: .trailing, relatedBy: .equal,
                                    toItem: backView, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint.init(item: redView, attribute: .height, relatedBy: .equal,
                                    toItem: yellowView, attribute: .height, multiplier: 1, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: yellowView, attribute: .top, relatedBy: .equal,
                                    toItem: redView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: yellowView, attribute: .leading, relatedBy: .equal,
                                    toItem: backView, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: yellowView, attribute: .trailing, relatedBy: .equal,
                                    toItem: backView, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint.init(item: yellowView, attribute: .centerX, relatedBy: .equal,
                                    toItem: backView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: yellowView, attribute: .centerY, relatedBy: .equal,
                                    toItem: backView, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: yellowView, attribute: .height, relatedBy: .equal,
                                    toItem: greenView, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: yellowView, attribute: .width, relatedBy: .equal,
                                    toItem: yellowView, attribute: .height, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: greenView, attribute: .top, relatedBy: .equal,
                                    toItem: yellowView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: greenView, attribute: .leading, relatedBy: .equal,
                                    toItem: backView, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint.init(item: greenView, attribute: .trailing, relatedBy: .equal,
                                    toItem: backView, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint.init(item: greenView, attribute: .bottom, relatedBy: .equal,
                                    toItem: backView, attribute: .bottom, multiplier: 1, constant: -10),
            
        ])
    }
    
}
