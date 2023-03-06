//
//  MainScreenRouter.swift
//  WeatherApp
//
//  Created by Raziel on 06.03.2023.
//

import UIKit

protocol IMainScreenRouter {
    func openMapScreen()
}

final class MainScreenRouter: IMainScreenRouter {

    // Dependencies
    weak var transitionHandler: UIViewController?

    // MARK: - IMainScreenRouter

    func openMapScreen() {
        let view: UIViewController = MapScreenViewController()
        transitionHandler?.navigationController?.pushViewController(view, animated: true)
    }
}
