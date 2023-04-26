//
//  Date + Extension.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

extension Date {

    func toString(_ format: String = "dd.MM.yyyy") -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }
}
