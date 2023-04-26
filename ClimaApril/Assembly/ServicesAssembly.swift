//
//  ServicesAssembly.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

class ServicesAssembly {

    private lazy var networkService: NetworkService = {
        NetworkService()
    }()

    private lazy var requestClime: URLRequestFactory = {
        URLRequestFactory(latitude: 55.755864, longitude: 37.617698)
    }()

    func makeClimeService() -> ClimeServicesProtocol {
        ClimeServices(networkService: networkService, requestFactory: requestClime)
    }

    func makeClimeLocationManager() -> ClimeLocationManager {
        ClimeLocationManager()
    }

}
