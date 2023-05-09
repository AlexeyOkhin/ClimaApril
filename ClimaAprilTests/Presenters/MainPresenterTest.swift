//
//  MainPresenterTest.swift
//  ClimaAprilTests
//
//  Created by Djinsolobzik on 09.05.2023.
//

import XCTest
@testable import ClimaApril

class MockView: MainViewProtocol {

    func reloadData() {

    }
    func refreshData() {

    }
    func showError(with error: String) {

    }
}



class MainPresenterTest: XCTestCase {

    let view = MockView()
    let climeService = ClimeServices(networkService: NetworkService(), requestFactory: URLRequestFactory(latitude: 5, longitude: 5))
    let locationManager = ClimeLocationManager()

    func testGetUrl() {
        //Arrange
        let presenter = MainPresenter(climeService: climeService, locationManager: locationManager)
        //Act
        let outputString = presenter.getUrlIcon(with: "Baz")
        //Assert
        XCTAssertEqual(outputString, "https://yastatic.net/weather/i/icons/funky/dark/Baz.svg")
    }
}


