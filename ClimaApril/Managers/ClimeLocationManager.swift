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

// MARK: - Init
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func updateLocation() {
        locationManager.requestLocation()
    }

    private func checkLocationAuthorizationStatus() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        default:
            return false
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        didUpdateLocations?(locationValue)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError?(error)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if checkLocationAuthorizationStatus() {
            guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            didUpdateLocations?(locationValue)
        }
    }
}
