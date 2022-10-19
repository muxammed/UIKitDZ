//
//  ByCodeViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 17.10.2022.
//

import UIKit

/// ByCodeViewController экран верстки анкорами кодом
class ByCodeViewController: UIViewController {
    
    // MARK: - Visual Components
    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    let yellowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    let greenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    // MARK: - Life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configure()
    }
    
    // MARK: - Public methods
    func configure() {
        view.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backView)
        backView.addSubview(redView)
        backView.addSubview(yellowView)
        backView.addSubview(greenView)
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
        ])
        
        NSLayoutConstraint.activate([
            
            redView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            redView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            redView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            
            yellowView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 10),
            yellowView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            yellowView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            yellowView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            
            greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 10),
            greenView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            greenView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            greenView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            
            redView.heightAnchor.constraint(equalTo: yellowView.heightAnchor, multiplier: 1, constant: 0),
            yellowView.heightAnchor.constraint(equalTo: greenView.heightAnchor, multiplier: 1, constant: 0),
            
            yellowView.widthAnchor.constraint(equalTo: yellowView.heightAnchor),
        ])
    }
}
