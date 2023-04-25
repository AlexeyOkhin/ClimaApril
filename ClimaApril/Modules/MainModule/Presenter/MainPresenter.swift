//
//  MainPresenter.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

final class MainPresenter {

    // MARK: - Properties

    var clime: ClimeModel? = nil
    weak var view: MainViewProtocol?
    let climeService: ClimeServicesProtocol
    let locationManager: ClimeLocationManager

    // MARK: - Init

    init(climeService: ClimeServicesProtocol, locationManager: ClimeLocationManager) {
        self.climeService = climeService
        self.locationManager = locationManager
    }

    private func loadClime(lat: Double, lon: Double) {
        climeService.getClime(lat: lat, lon: lon) { [weak self] result in
            switch result {

            case .success(let climeModel):
                DispatchQueue.main.async {
                    self?.clime = climeModel
                    self?.view?.reloadData()
                    self?.view?.refreshData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(with: error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Extension MainPresenterProtocol

extension MainPresenter: MainPresenterProtocol {

    func getDayWeek(at index: Int) -> String {
        guard let clime else { return ""}
        if index == 0 {
            return "Сегодня"
        }
        let dateTs = clime.forecasts[index].dateTs
        let date = Date(timeIntervalSince1970: dateTs)
        let dayWeek = date.toString("EEE")
        return dayWeek
    }

    func getUrlIcon(with icon: String) -> String {
        let stringUrl = "https://yastatic.net/weather/i/icons/funky/dark/" + icon + ".svg"
        return stringUrl
    }

    func loadLocationClime() {
        locationManager.updateLocation()
        locationManager.didUpdateLocations = { [weak self] location in
            self?.loadClime(lat: location.latitude, lon: location.longitude)
        }

        locationManager.didFailWithError = { [weak self] error in
            self?.loadClime(lat: 55.755864, lon: 37.617698)
        }
    }

}
