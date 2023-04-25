//
//  AssemblyModules.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import UIKit

protocol AssemblyModulesProtocol {

    func makeMainModule() -> UIViewController
}

class AssemblyModules: AssemblyModulesProtocol {

    private let servicesAssembly: ServicesAssembly

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }

    func makeMainModule() -> UIViewController {

        let view = MainViewController()

        return view
    }
}
