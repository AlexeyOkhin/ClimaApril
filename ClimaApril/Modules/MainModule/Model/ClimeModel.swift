//
//  ClimeModel.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import Foundation

struct WeatherResponse: Codable {
    let now: Int
}


struct ClimeModel: Decodable {
    let geoObject: GeoObjectModel
    let fact: FactModel
    let forecasts: [ForecastsModel]
    let now: Int
}

struct GeoObjectModel: Decodable {
    let locality: LocalityModel
}

struct LocalityModel: Decodable {
    let name: String
}

struct FactModel: Decodable {
    let temp: Int
    let icon: String
    let condition: String
}

struct ForecastsModel: Decodable {
    let dateTs: Date
    let week: Int
    let parts: PartModel
}

struct PartModel: Decodable {
    let dayShort: DayModel
}

struct DayModel: Decodable {
    let temp: Int
    let tempMin: Int
    let icon: String
}
