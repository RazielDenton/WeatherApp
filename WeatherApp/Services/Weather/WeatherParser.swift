//
//  WeatherParser.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

final class WeatherParser: Parser {

    func parse(result: Any) -> Result<Any, CustomError> {
        if let dictionary: [String: Any] = result as? [String: Any],
           let result: [[String: Any]] = dictionary["list"] as? [[String: Any]] {
            let weatherForecast: [WeatherForecastData] = result.compactMap { WeatherForecastData(dictionary: $0) }
            return .success(weatherForecast)
        } else if let dictionary: [String: Any] = result as? [String: Any],
                  let currentWeather: WeatherForecastData = WeatherForecastData(dictionary: dictionary) {
            return .success(currentWeather)
        } else {
            return .failure(.parser)
        }
    }
}
