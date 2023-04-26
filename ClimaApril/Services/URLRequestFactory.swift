//
//  URLRequestFactory.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

protocol URLRequestFactoryProtocol {
    func getClimeRequest(lat: Double, lon: Double) throws -> URLRequest

}

final class URLRequestFactory: URLRequestFactoryProtocol {

    private let host = "api.weather.yandex.ru"
    private let latitude: Double
    private let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    func getClimeRequest(lat: Double, lon: Double) throws -> URLRequest {
        guard let url = url(with: "/v2/forecast", lat: lat, lon: lon ) else {
            throw ClimeError.makeRequest
        }
        return URLRequest(url: url)
    }
}

private extension URLRequestFactory {
    private func url(with path: String, lat: Double, lon: Double) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        let queryLatitude = URLQueryItem(name: "lat", value: String(lat))
        let queryLongitude = URLQueryItem(name: "lon", value: String(lon))

        urlComponents.queryItems = [queryLatitude, queryLongitude]

        guard let url = urlComponents.url else {
            return nil
        }

        print(url)

        return url
    }
}
