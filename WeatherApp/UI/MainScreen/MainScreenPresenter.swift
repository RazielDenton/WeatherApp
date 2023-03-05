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
        weatherService.getCurrentWeather { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let currentWeather):
                self.viewModel = self.mainScreenViewModelFactory.makeViewModel(cityName: nil,
                                                                               currentWeather: currentWeather,
                                                                               weatherForecast: [],
                                                                               actions: self)
                self.view?.reloadData()
            case .failure(let error):
                print(error)
            }
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
}
