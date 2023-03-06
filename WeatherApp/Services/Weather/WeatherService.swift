//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

protocol IWeatherService {
    func getCurrentWeather(for location: LocationModel?, completion: @escaping (Result<(WeatherForecastData), Error>) -> Void)
    func getWeatherForecast(for location: LocationModel?, completion: @escaping (Result<([WeatherForecastData]), Error>) -> Void)
}

final class WeatherService: IWeatherService {

    // Dependencies
    private let networkService: INetworkService
    private let weatherParser: Parser

    // MARK: - Initialization

    init(networkService: INetworkService = NetworkService(),
         weatherParser: Parser = WeatherParser()) {
        self.networkService = networkService
        self.weatherParser = weatherParser
    }

    // MARK: - IWeatherService

    func getCurrentWeather(for location: LocationModel?, completion: @escaping (Result<(WeatherForecastData), Error>) -> Void) {
        let parameters: [String: Any] = [
            "appid": "67f2837025add6d1f8b030729f0c1363",
            "units": "metric",
            "lat": location?.latitude ?? 50.4501,
            "lon": location?.longitude ?? 30.5234
        ]

        let request: Request = Request(path: "weather", method: .get, parameters: parameters)
        networkService.execute(request: request, parser: weatherParser) { result in
            switch result {
            case .success(let data):
                if let data: WeatherForecastData = data as? WeatherForecastData {
                    completion(.success(data))
                } else {
                    completion(.failure(CustomError.parser))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getWeatherForecast(for location: LocationModel?, completion: @escaping (Result<([WeatherForecastData]), Error>) -> Void) {
        let parameters: [String: Any] = [
            "appid": "67f2837025add6d1f8b030729f0c1363",
            "units": "metric",
            "lat": location?.latitude ?? 50.4501,
            "lon": location?.longitude ?? 30.5234
        ]

        let request: Request = Request(path: "forecast", method: .get, parameters: parameters)
        networkService.execute(request: request, parser: weatherParser) { result in
            switch result {
            case .success(let data):
                if let data: [WeatherForecastData] = data as? [WeatherForecastData] {
                    completion(.success(data))
                } else {
                    completion(.failure(CustomError.parser))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
