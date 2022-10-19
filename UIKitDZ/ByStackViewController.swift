//
//  ByStackViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 19.10.2022.
//

import UIKit
/// ByStackViewController - экран создания светофора со stackView
final class ByStackViewController: UIViewController {
    
    // MARK: - Visual components
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .black
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
    }
    
    // MARK: - Private methods
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(redView)
        stackView.addArrangedSubview(yellowView)
        stackView.addArrangedSubview(greenView)
        
        addConstraints()
    }
    
    private func addConstraints() {
        let visualForString = "V:|-10-[v0(==v1)]-10-[v1(==v2)]-10-[v2]-10-|"
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualForString,
                                                           options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                                                           views: ["v0": redView, "v1": yellowView, "v2": greenView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|",
                                                           options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                                                           views: ["v0": redView]))
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            redView.widthAnchor.constraint(equalTo: redView.heightAnchor),
            yellowView.widthAnchor.constraint(equalTo: yellowView.heightAnchor, constant: 0),
            greenView.widthAnchor.constraint(equalTo: greenView.heightAnchor, constant: 0),
        ])
    }
}
