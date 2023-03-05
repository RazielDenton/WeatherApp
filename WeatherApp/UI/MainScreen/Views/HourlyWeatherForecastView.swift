//
//  HourlyWeatherForecastView.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

class HourlyWeatherForecastView: UIView {

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setup() {
        self.backgroundColor = R.color.mainColour2()
    }
}
