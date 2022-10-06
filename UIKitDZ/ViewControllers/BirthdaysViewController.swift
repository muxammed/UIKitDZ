//
//  BirthdaysViewController.swift
//  UIKitDZ
//
//  Created by muxammed on 24.09.2022.
//

import UIKit
/// это BirthdaysViewController - контроллер с данными о днях рождениях c кнопкой добавления
final class BirthdaysViewController: UIViewController {
    
    // MARK: - Public Properties
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    var statusBarHeight: CGFloat = 0
    var navBarHeight: CGFloat = 0
    var persons: [Person] = []

    // MARK: - UIViewController(*)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addDummyData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
    }
    // MARK: - Public methods
    func addDummyData() {
        guard let image = UIImage(systemName: "person.crop.circle.fill") else { return }
        persons.append(Person(name: "Ahmet",
                              personImage: image,
                              birthDate: dateFormatter.date(from: "11.05.1984") ?? Date(),
                              gender: "male",
                              instagram: "@niznayu"))
        persons.append(Person(name: "Muhammet",
                              personImage: image,
                              birthDate: dateFormatter.date(from: "10.05.1984") ?? Date(),
                              gender: "male",
                              instagram: "@netuinstagramma"))
    }
    func setupViews() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                                    .font: UIFont.roundedMplus(.bold, size: 20)]
        navigationItem.title = "Birthday"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTappedAction))
        statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        
        for personIndex in 0..<persons.count {
            let nextPersonViewY = CGFloat(personIndex * 90) + navBarHeight + statusBarHeight
            let personView = PersonView(frame:
                                            CGRect(x: 10,
                                                   y: nextPersonViewY,
                                                   width: view.frame.width,
                                                   height: 90),
                                        person: persons[personIndex])
            personView.alpha = 0
            self.view.addSubview(personView)
            UIView.animate(withDuration: 0.7) {
                personView.alpha = 1
            }
        }
    }
    
    func addNewElement(person: Person) {
        let nextPersonViewY = CGFloat(persons.count * 90) + navBarHeight + statusBarHeight
        let personView = PersonView(frame:
                                        CGRect(x: 10,
                                               y: nextPersonViewY,
                                               width: view.frame.width,
                                               height: 90),
                                    person: person)
        personView.alpha = 0
        self.view.addSubview(personView)
        UIView.animate(withDuration: 0.7) {
            personView.alpha = 1
        }
        persons.append(person)
    }
    
    @objc func addTappedAction() {
        let addPersonVC = AddPersonViewController()
        addPersonVC.delegate = self
        navigationController?.present(addPersonVC, animated: true, completion: nil)
    }
}

extension BirthdaysViewController: PersonEnterDelegate {
    func newPersonEntered(person: Person) {
        addNewElement(person: person)
    }
}
