//
//  MainScreenRouter.swift
//  WeatherApp
//
//  Created by Raziel on 06.03.2023.
//

import UIKit

protocol IMainScreenRouter {
    func openMapScreen(delegate: MapViewActions, locationService: ILocationService)
}

final class MainScreenRouter: IMainScreenRouter {

    // Dependencies
    weak var transitionHandler: UIViewController?

    // MARK: - IMainScreenRouter

    func openMapScreen(delegate: MapViewActions, locationService: ILocationService) {
        let view: UIViewController = MapScreenViewController(delegate: delegate, locationService: locationService)
        transitionHandler?.navigationController?.pushViewController(view, animated: true)
    }
}
