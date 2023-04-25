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
    let condition: Condition

    enum CodingKeys: CodingKey {
        case temp
        case icon
        case condition
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decode(Int.self, forKey: .temp)
        self.icon = try container.decode(String.self, forKey: .icon)
        let condition = try container.decode(String.self, forKey: .condition)
        self.condition = .init(rawValue: condition) ?? .lightRain
    }
}

struct ForecastsModel: Decodable {
    let dateTs: Double
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

enum Condition: String {
case lightRain = "Cлабый дождь"

    init?(rawValue: String) {
        switch rawValue {
        case "light-rain": self = .lightRain

        default:
            return nil
        }
    }

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
