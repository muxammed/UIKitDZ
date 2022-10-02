//
//  Person.swift
//  UIKitDZ
//
//  Created by muxammed on 26.09.2022.
//

import Foundation
import UIKit
/// перечисления гендоров персоны
enum Gender {
    case male
    case female
}

/// Структура Person которая хранит данные о человеке и имеет метод для подсчета оставшихся дней до его дня рождения
struct Person {
    var name: String
    var personImage: UIImage
    var birthDate: Date
    var gender: String
    var instagram: String
    
    func getBirthDayWeekday() -> String {
        let currentDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        var nextBirthDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: birthDate)
        nextBirthDateComponents.year = currentDateComponents.year
        var nextDate = Calendar.current.date(from: nextBirthDateComponents) ?? Date()
        
        if Date() > nextDate {
            nextBirthDateComponents.year? += 1
            nextDate = Calendar.current.date(from: nextBirthDateComponents) ?? Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: nextDate)
    }
    
    func daysToBirthday() -> Int {
        let currentDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        var nextBirthDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: birthDate)
        nextBirthDateComponents.year = currentDateComponents.year
        var nextDate = Calendar.current.date(from: nextBirthDateComponents) ?? Date()
        
        if Date() > nextDate {
            nextBirthDateComponents.year? += 1
            nextDate = Calendar.current.date(from: nextBirthDateComponents) ?? Date()
        }
        let numberOfDays = Calendar.current.dateComponents([.day], from: Date(),
                                                           to: nextDate)
        return numberOfDays.day ?? 0
    }
    
    func getAge() -> Int {
        let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        return age
    }
}
