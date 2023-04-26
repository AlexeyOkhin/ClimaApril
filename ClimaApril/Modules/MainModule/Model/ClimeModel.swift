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
        self.condition = .init(rawValue: condition) ?? .unknown
    }
}

struct ForecastsModel: Decodable {
    let dateTs: Double
    let week: Int
    let parts: PartModel
    let hours: [HourClimeModel]
}

struct PartModel: Decodable {
    let dayShort: DayModel
}

struct HourClimeModel: Decodable {
    let hour: String
    let hourTs: Int
    let temp: Int
    let icon: String
}

struct DayModel: Decodable {
    let temp: Int
    let tempMin: Int
    let icon: String
}

enum Condition: String {

    case lightRain = "Небольшой дождь"
    case clear = " Ясно"
    case partlyCloudy = "Малооблачно"
    case cloudy = "Облачно с прояснениями"
    case overcast = "Пасмурно"
    case drizzle = "Морось"
    case rain = "Дождь"
    case moderateRain = "Умереный дождь"
    case heavyRain = "Сильный дождь"
    case continuousHeavyRain = "Длительный сильный дождь"
    case showers = "Ливень"
    case wetSnow = "Дождь со снегом"
    case lightSnow = "Небольшой снег"
    case snow = "Снег"
    case snowShowers = "Снегопад"
    case hail = "Град"
    case thunderstorm = "Гроза"
    case thunderstormWithRain = "Дождь с грозой"
    case thunderstormWithHail = "Гроза с градом"
    case unknown = "Неизвестное явление"

    init?(rawValue: String) {
        switch rawValue {
        case "light-rain": self = .lightRain
        case "clear": self = .clear
        case "partly-cloudy": self = .partlyCloudy
        case "cloudy": self = .cloudy
        case "overcast": self = .overcast
        case "drizzle": self = .drizzle
        case "rain": self = .rain
        case "moderate-rain": self = .moderateRain
        case "heavy-rain": self = .heavyRain
        case "continuous-heavy-rain": self = .continuousHeavyRain
        case "showers": self = .showers
        case "wet-snow": self = .wetSnow
        case "light-snow": self = .lightSnow
        case "snow": self = .snow
        case "snow-showers": self = .snowShowers
        case "hail": self = .hail
        case "thunderstorm": self = .thunderstorm
        case "thunderstorm-with-rain": self = .thunderstormWithRain
        case "thunderstorm-with-hail": self = .thunderstormWithHail
        case "unknown": self = .unknown
        default:
            return nil
        }
    }
}
