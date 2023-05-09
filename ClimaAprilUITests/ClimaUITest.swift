//
//  ClimaUITest.swift
//  ClimaAprilUITests
//
//  Created by Djinsolobzik on 10.05.2023.
//

import XCTest

class ClimaAprilUITests: XCTestCase {

    func testShowWeatherCity() {
        //Arrange
        let app = XCUIApplication()
        app.launch()
        //Act
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Москва").element.tap()
        //Assert
        XCTAssertTrue(collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Москва").element.exists)
    }
}
