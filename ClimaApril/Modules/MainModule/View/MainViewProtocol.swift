//
//  MainViewProtocol.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {

    func reloadData()
    func refreshData()
    func showError(with error: String)

}
