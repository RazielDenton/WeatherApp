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
        let mainScreenViewModelFactory: MainScreenViewModelFactory = MainScreenViewModelFactory()
        let presenter: MainScreenPresenter = MainScreenPresenter(weatherService: weatherService,
                                                                 mainScreenViewModelFactory: mainScreenViewModelFactory)
        let view: MainScreenViewController = MainScreenViewController(presenter: presenter)
        presenter.view = view

        return view
    }
}
