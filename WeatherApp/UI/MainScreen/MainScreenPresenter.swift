//
//  MainScreenPresenter.swift
//  WeatherApp
//
//  Created by Raziel on 05.03.2023.
//

protocol MainScreenViewActions: AnyObject {
    func didTapPickLocation()
    func didTapMyLocation()
    func didTapDayForecastCell()
}

protocol IMainScreenPresenter {
    var viewModel: MainScreenViewModel { get }
    func viewDidLoad()
}

final class MainScreenPresenter: IMainScreenPresenter, MainScreenViewActions {

    // Dependencies
    private let weatherService: IWeatherService
    private let mainScreenViewModelFactory: IMainScreenViewModelFactory
    weak var view: IMainScreenViewController?

    // Properties
    var viewModel: MainScreenViewModel

    // MARK: - Initialization

    init(weatherService: IWeatherService, mainScreenViewModelFactory: IMainScreenViewModelFactory) {
        self.weatherService = weatherService
        self.mainScreenViewModelFactory = mainScreenViewModelFactory
        self.viewModel = .empty
    }

    // MARK: - IMainScreenPresenter

    func viewDidLoad() {
        Task {
            async let currentWeather: WeatherForecastData = getCurrentWeather()
            async let weatherForecast: [WeatherForecastData] = getWeatherForecast()

            viewModel = try await mainScreenViewModelFactory.makeViewModel(cityName: nil,
                                                                           currentWeather: currentWeather,
                                                                           weatherForecast: weatherForecast,
                                                                           actions: self)
            view?.reloadData()
        }
    }

    // MARK: - MainScreenViewActions

    func didTapPickLocation() {
        print("open the map")
    }

    func didTapMyLocation() {
        print("get weather for the current user location")
    }

    func didTapDayForecastCell() {
        print("cell tapped")
    }

    // MARK: - Private

    private func getCurrentWeather() async throws -> WeatherForecastData {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<WeatherForecastData, Error>) in
            weatherService.getCurrentWeather { result in
                switch result {
                case .success(let currentWeather):
                    continuation.resume(returning: currentWeather)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }

    private func getWeatherForecast() async throws -> [WeatherForecastData] {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[WeatherForecastData], Error>) in
            weatherService.getWeatherForecast { result in
                switch result {
                case .success(let weatherForecast):
                    continuation.resume(returning: weatherForecast)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}
