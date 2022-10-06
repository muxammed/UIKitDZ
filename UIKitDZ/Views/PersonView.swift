//
//  PersonView.swift
//  UIKitDZ
//
//  Created by muxammed on 25.09.2022.
//
import UIKit

/// кастомный PersonView что бы переиспользовать включает в себя настраиваемые UILabel'ы с данные из структуры Person которая передается во внутрь как параметр также рассчитывает оставшиеся дни до дня рождения Person'а
/// - Parameters
///  - person: Структура Person
final class PersonView: UIView {
    
    var person: Person?
    
    var personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.inactiveColor
        return view
    }()
    
    var centeredView = UIView()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.roundedMplus(.bold, size: 17)
        label.textColor = .black
        label.text = "TEST"
        return label
    }()
    
    var ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.roundedMplus(.medium, size: 14)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var remainDays: UILabel = {
        let label = UILabel()
        label.font = UIFont.roundedMplus(.medium, size: 14)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter
    }()
    
    init(frame: CGRect, person: Person) {
        super.init(frame: frame)
        nameLabel.text = person.name
        remainDays.text = "\(person.daysToBirthday()) дней"
        ageLabel.text = "\(dateFormatter.string(from: person.birthDate)), в "
                        + "\(person.getBirthDayWeekday()) исполнится \(person.getAge() + 1) лет"
        personImage.image = person.personImage
        addViews()
    }
    
    func addViews() {
        addSubview(personImage)
        addSubview(centeredView)
        centeredView.addSubview(nameLabel)
        centeredView.addSubview(ageLabel)
        centeredView.addSubview(remainDays)
        addSubview(underlineView)
    }
    
    func setupViews() {
        personImage.frame = CGRect(x: 5, y: 5, width: 80, height: 80)
        centeredView.frame = CGRect(x: 90, y: 0, width: frame.width - 110,
                                    height: nameLabel.font.lineHeight + 2 + ageLabel.font.lineHeight)
        nameLabel.frame = CGRect(x: 0, y: 0, width: centeredView.frame.width / 2, height: nameLabel.font.lineHeight)
        remainDays.frame = CGRect(x: centeredView.frame.width / 2, y: 0,
                                  width: centeredView.frame.width / 2, height: remainDays.font.lineHeight)
        ageLabel.frame = CGRect(x: 0, y: nameLabel.font.lineHeight + 2,
                                width: centeredView.frame.width, height: ageLabel.font.lineHeight)
        
        centeredView.center.y = personImage.center.y
        underlineView.frame = CGRect(x: 10, y: personImage.frame.maxY + 5, width: self.frame.width, height: 2)
    }
    override func layoutSubviews() {
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
