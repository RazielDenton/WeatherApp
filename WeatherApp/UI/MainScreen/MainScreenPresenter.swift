//
//  MainScreenPresenter.swift
//  WeatherApp
//
//  Created by Raziel on 05.03.2023.
//

import Combine
import Foundation

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
    private let locationService: ILocationService
    private let router: IMainScreenRouter
    private let mainScreenViewModelFactory: IMainScreenViewModelFactory
    weak var view: IMainScreenViewController?

    // Properties
    var viewModel: MainScreenViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(weatherService: IWeatherService,
         locationService: ILocationService,
         router: IMainScreenRouter,
         mainScreenViewModelFactory: IMainScreenViewModelFactory) {
        self.weatherService = weatherService
        self.locationService = locationService
        self.router = router
        self.mainScreenViewModelFactory = mainScreenViewModelFactory
        self.viewModel = .empty
    }

    // MARK: - IMainScreenPresenter

    func viewDidLoad() {
        getWeatherData(for: nil)
        setupLocationObserver()
    }

    // MARK: - MainScreenViewActions

    func didTapPickLocation() {
        router.openMapScreen()
    }

    func didTapMyLocation() {
        locationService.identifyUserLocation()
    }

    func didTapDayForecastCell() {
        print("cell tapped")
    }

    // MARK: - Private

    private func getWeatherData(for location: LocationModel?) {
        Task {
            async let currentWeather: WeatherForecastData = getCurrentWeather(for: location)
            async let weatherForecast: [WeatherForecastData] = getWeatherForecast(for: location)

            viewModel = try await mainScreenViewModelFactory.makeViewModel(cityName: location?.cityName,
                                                                           currentWeather: currentWeather,
                                                                           weatherForecast: weatherForecast,
                                                                           actions: self)
            DispatchQueue.main.async { [self] in
                view?.reloadData()
            }
        }
    }

    private func getCurrentWeather(for location: LocationModel?) async throws -> WeatherForecastData {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<WeatherForecastData, Error>) in
            weatherService.getCurrentWeather(for: location) { result in
                switch result {
                case .success(let currentWeather):
                    continuation.resume(returning: currentWeather)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }

    private func getWeatherForecast(for location: LocationModel?) async throws -> [WeatherForecastData] {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[WeatherForecastData], Error>) in
            weatherService.getWeatherForecast(for: location) { result in
                switch result {
                case .success(let weatherForecast):
                    continuation.resume(returning: weatherForecast)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }

    private func setupLocationObserver() {
        locationService.locationModelPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locationModel in
                guard let location: LocationModel = locationModel else { return }
                self?.getWeatherData(for: location)
            }.store(in: &cancellables)
    }
}
