//
//  ViewController.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

class ViewController: UIViewController {

    // Dependencies
    private let weatherService: WeatherService = WeatherService()

    // UI elements
    private let temperatureLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let someView: UIView = UIView()
        someView.backgroundColor = .white
        self.view.addSubview(someView)
        someView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            someView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            someView.topAnchor.constraint(equalTo: self.view.topAnchor),
            someView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            someView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        self.view.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        getWeatherForecast()
    }

    private func getWeatherForecast() {
        weatherService.getCurrentWeather { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherForecast):
                self.temperatureLabel.text = "\(weatherForecast.minTemp)°/ \(weatherForecast.maxTemp)°"
            case .failure(let error):
                print(error)
            }
        }
    }
}
