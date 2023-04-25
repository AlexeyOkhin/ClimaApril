//
//  MainPresenterProtocol.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

protocol MainPresenterProtocol {

    var clime: ClimeModel? { get }

    func loadClime()
    func getUrlIcon(with: String) -> String
    func getDayWeek(at index: Int) -> String
}
