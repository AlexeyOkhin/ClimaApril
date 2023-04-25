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
        URLRequestFactory(latitude: 51.7727, longitude: 55.0988)
    }()

    func makeClimeService() -> ClimeServicesProtocol {
        ClimeServices(networkService: networkService, requestFactory: requestClime)
    }

    func makeClimeLocationService() -> ClimeLocationServiceProtocol {
        ClimeLocationService()
    }

}
