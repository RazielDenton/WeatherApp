//
//  DetailWeatherView.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

class DetailWeatherView: UIView {

    // UI elements
    private let dateLabel: UILabel = UILabel()
    private let weatherImageView: UIImageView = UIImageView()

    private let weatherParametersIconsStackView: UIStackView = UIStackView()
    private let tempImageView: UIImageView = UIImageView()
    private let humidImageView: UIImageView = UIImageView()
    private let windImageView: UIImageView = UIImageView()

    private let weatherParametersStackView: UIStackView = UIStackView()
    private let temperatureLabel: UILabel = UILabel()
    private let humidityLabel: UILabel = UILabel()
    private let windLabel: UILabel = UILabel()

    private let windDirection: UIImageView = UIImageView()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setup(with viewModel: DetailWeatherViewModel) {
        dateLabel.text = viewModel.date
        weatherImageView.image = viewModel.weatherImage

        tempImageView.image = viewModel.temperatureImage
        humidImageView.image = viewModel.humidityImage
        windImageView.image = viewModel.windImage

        temperatureLabel.text = viewModel.temperature
        humidityLabel.text = viewModel.humidity
        windLabel.text = viewModel.windSpeed

        windDirection.image = viewModel.windDirection
    }

    // MARK: - Private

    private func setup() {
        self.backgroundColor = R.color.mainColour1()

        setupDateAndWeatherImage()
        setupWeatherParametersIcons()
        setupWeatherParameters()
        setupConstraints()
    }

    private func setupDateAndWeatherImage() {
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 16)
        self.addSubview(dateLabel)

        weatherImageView.contentMode = .scaleAspectFit
        self.addSubview(weatherImageView)
    }

    private func setupWeatherParametersIcons() {
        tempImageView.contentMode = .scaleAspectFit
        humidImageView.contentMode = .scaleAspectFit
        windImageView.contentMode = .scaleAspectFit

        weatherParametersIconsStackView.alignment = .center
        weatherParametersIconsStackView.distribution = .equalCentering
        weatherParametersIconsStackView.axis = .vertical

        weatherParametersIconsStackView.addArrangedSubview(tempImageView)
        weatherParametersIconsStackView.addArrangedSubview(humidImageView)
        weatherParametersIconsStackView.addArrangedSubview(windImageView)

        self.addSubview(weatherParametersIconsStackView)
    }

    private func setupWeatherParameters() {
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 18)

        humidityLabel.textColor = .white
        humidityLabel.font = .systemFont(ofSize: 18)

        windLabel.textColor = .white
        windLabel.font = .systemFont(ofSize: 18)

        weatherParametersStackView.alignment = .leading
        weatherParametersStackView.distribution = .equalCentering
        weatherParametersStackView.axis = .vertical

        weatherParametersStackView.addArrangedSubview(temperatureLabel)
        weatherParametersStackView.addArrangedSubview(humidityLabel)
        weatherParametersStackView.addArrangedSubview(windLabel)

        self.addSubview(weatherParametersStackView)

        windDirection.contentMode = .scaleAspectFit
        self.addSubview(windDirection)
    }

    private func setupConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherParametersIconsStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherParametersStackView.translatesAutoresizingMaskIntoConstraints = false
        windDirection.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),

            weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            weatherImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            weatherImageView.heightAnchor.constraint(equalToConstant: 150),
            weatherImageView.widthAnchor.constraint(equalToConstant: 150),

            tempImageView.heightAnchor.constraint(equalToConstant: 20),
            tempImageView.widthAnchor.constraint(equalToConstant: 20),
            humidImageView.heightAnchor.constraint(equalToConstant: 20),
            humidImageView.widthAnchor.constraint(equalToConstant: 20),
            windImageView.heightAnchor.constraint(equalToConstant: 20),
            windImageView.widthAnchor.constraint(equalToConstant: 20),

            weatherParametersIconsStackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 40),
            weatherParametersIconsStackView.topAnchor.constraint(equalTo: weatherImageView.topAnchor, constant: 30),
            weatherParametersIconsStackView.bottomAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: -30),

            weatherParametersStackView.leadingAnchor.constraint(equalTo: weatherParametersIconsStackView.trailingAnchor, constant: 15),
            weatherParametersStackView.topAnchor.constraint(equalTo: weatherParametersIconsStackView.topAnchor),
            weatherParametersStackView.bottomAnchor.constraint(equalTo: weatherParametersIconsStackView.bottomAnchor),

            windDirection.leadingAnchor.constraint(equalTo: weatherParametersStackView.trailingAnchor, constant: 5),
            windDirection.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windDirection.heightAnchor.constraint(equalToConstant: 20),
            windDirection.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
