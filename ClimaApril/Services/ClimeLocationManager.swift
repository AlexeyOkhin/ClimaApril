//
//  ClimeLocationManager.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation
import CoreLocation

final class ClimeLocationManager: NSObject, CLLocationManagerDelegate {

    var didUpdateLocations: ((CLLocationCoordinate2D) -> Void)?
    var didFailWithError: ((Error) -> Void)?

    private let locationManager = CLLocationManager()


    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        updateLocation()
    }

    func updateLocation() {
        locationManager.requestLocation()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        didUpdateLocations?(locValue)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError?(error)
    }

//    private func getLocationRequest(latitude: Double, longitude: Double) throws -> URLRequest {
//
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.weather.yandex.ru"
//        urlComponents.path = "/v2/forecast"
//        let queryLatitude = URLQueryItem(name: "lat", value: String(latitude))
//        let queryLongitude = URLQueryItem(name: "lon", value: String(longitude))
//
//        urlComponents.queryItems = [queryLatitude, queryLongitude]
//
//        guard let url = urlComponents.url else {
//            throw ClimeError.makeRequest
//        }
//        return URLRequest(url: url)
//    }
}
