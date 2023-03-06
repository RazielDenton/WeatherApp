//
//  MainScreenAssembly.swift
//  WeatherApp
//
//  Created by Raziel on 05.03.2023.
//

import UIKit

final class MainScreenAssembly {

    func assemble() -> UIViewController {
        let weatherService: WeatherService = WeatherService()
        let locationService: LocationService = LocationService()
        let mainScreenViewModelFactory: MainScreenViewModelFactory = MainScreenViewModelFactory()
        let router: MainScreenRouter = MainScreenRouter()
        let presenter: MainScreenPresenter = MainScreenPresenter(weatherService: weatherService,
                                                                 locationService: locationService,
                                                                 router: router,
                                                                 mainScreenViewModelFactory: mainScreenViewModelFactory)
        let view: MainScreenViewController = MainScreenViewController(presenter: presenter)
        presenter.view = view
        router.transitionHandler = view

        return view
    }
}
