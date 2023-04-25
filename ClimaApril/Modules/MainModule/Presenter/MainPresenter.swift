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
    let locationService: ClimeLocationServiceProtocol

    // MARK: - Init

    init(climeService: ClimeServicesProtocol, locationService: ClimeLocationServiceProtocol) {
        self.climeService = climeService
        self.locationService = locationService
    }
}

// MARK: - Extension MainPresenterProtocol

extension MainPresenter: MainPresenterProtocol {

    func loadClime() {
        climeService.getClime { [weak self] result in
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
