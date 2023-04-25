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
        URLRequestFactory(latitude: 0, longitude: 0)
    }()

    func makeClimeService() -> ClimeServicesProtocol {
        ClimeServices(networkService: networkService, requestFactory: requestClime)
    }

}
