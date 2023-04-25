//
//  ClimeServices.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

protocol ClimeServicesProtocol {
    func getClime(completion: @escaping (Result<ClimeModel, Error>) -> Void)
}

class ClimeServices: ClimeServicesProtocol {

    private let networkService: NetworkService
    private let requestFactory: URLRequestFactoryProtocol

    init(networkService: NetworkService,
         requestFactory: URLRequestFactoryProtocol) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }

    func getClime(completion: @escaping (Result<ClimeModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getClimeRequest()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }

    }
}
