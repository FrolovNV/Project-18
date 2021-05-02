//
//  DateFormatter.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 29.04.2021.
//

import Foundation


class DateFormatterToAndFrom {
    static let shared = DateFormatterToAndFrom()
    
    let formatter = DateFormatter()
    
    init() {
        formatter.dateFormat = "dd.MM.yyyy"
    }
    
    func getStringFromDate(date: Date)->String {
        return formatter.string(from: date)
    }
}
