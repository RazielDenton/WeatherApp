//
//  WeatherForecastData.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import Foundation

struct WeatherForecastData {
    let timestamp: Int
    let weatherConditionCode: Int
    let temperature: Int
    let minTemp: Int
    let maxTemp: Int
    let humidity: Int
    let wind: Wind

    // MARK: - Initialization

    init(timestamp: Int,
         weatherConditionCode: Int,
         temperature: Int,
         minTemp: Int,
         maxTemp: Int,
         humidity: Int,
         wind: Wind) {
        self.timestamp = timestamp
        self.weatherConditionCode = weatherConditionCode
        self.temperature = temperature
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.humidity = humidity
        self.wind = wind
    }

    init?(dictionary: [String: Any]) {
        guard let timestamp: Int = dictionary["dt"] as? Int,
              let weatherDataArray: [Any] = dictionary["weather"] as? [Any],
              let weatherData: [String: Any] = weatherDataArray.first as? [String: Any],
              let weatherConditionCode: Int = weatherData["id"] as? Int,
              let mainData: [String: Any] = dictionary["main"] as? [String: Any],
              let temperature: Double = mainData["temp"] as? Double,
              let minTemp: Double = mainData["temp_min"] as? Double,
              let maxTemp: Double = mainData["temp_max"] as? Double,
              let humidity: Double = mainData["humidity"] as? Double,
              let windData: [String: Any] = dictionary["wind"] as? [String: Any],
              let windSpeed: Double = windData["speed"] as? Double,
              let windDeg: Int = windData["deg"] as? Int else {
                  print("⚠️ Failed to parse WeatherForecastData model")
                  return nil
        }

        self.timestamp = timestamp
        self.weatherConditionCode = weatherConditionCode
        self.temperature = Int(temperature.rounded())
        self.minTemp = Int(minTemp.rounded())
        self.maxTemp = Int(maxTemp.rounded())
        self.humidity = Int(humidity.rounded())
        self.wind = Wind(speed: windSpeed, deg: windDeg)
    }
}

// MARK: - Wind
struct Wind {
    let speed: Double
    let deg: Int
}
