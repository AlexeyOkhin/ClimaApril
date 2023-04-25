//
//  NetworkService.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

class NetworkService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(ClimeError.noData))
                return
            }

            do {
                try self?.handleStatusCode(response: response)

                let model = try JSONDecoder().decode(T.self, from: data)

                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

private extension NetworkService {
    func handleStatusCode(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }

        switch httpResponse.statusCode {
        case (100...299):
            return

        case (300...399):
            throw ClimeError.redirect

        case (400...499):
            throw ClimeError.badRequest

        case (500...599):
            throw ClimeError.serverError

        default:
            throw ClimeError.unexpectedStatus
        }
    }
}

