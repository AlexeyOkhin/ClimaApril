//
//  ClimeModel.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import Foundation

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
    let dateTs: Double
    var dayWeek: String {
        let date = Date(timeIntervalSince1970: dateTs)
        let dayWeek = date.toString("EEE")
        return dayWeek
    }
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

/*
 Код расшифровки погодного описания. Возможные значения:
 clear — ясно.
 partly-cloudy — малооблачно.
 cloudy — облачно с прояснениями.
 overcast — пасмурно.
 drizzle — морось.
 light-rain — небольшой дождь.
 rain — дождь.
 moderate-rain — умеренно сильный дождь.
 heavy-rain — сильный дождь.
 continuous-heavy-rain — длительный сильный дождь.
 showers — ливень.
 wet-snow — дождь со снегом.
 light-snow — небольшой снег.
 snow — снег.
 snow-showers — снегопад.
 hail — град.
 thunderstorm — гроза.
 thunderstorm-with-rain — дождь с грозой.
 thunderstorm-with-hail — гроза с градом.
 */
