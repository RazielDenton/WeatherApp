//
//  DailyWeatherForecastCell.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

final class DailyWeatherForecastCell: UITableViewCell {

    // UI elements
    private let weekdayLabel: UILabel = UILabel()
    private let temperatureLabel: UILabel = UILabel()
    private let weatherImageView: UIImageView = UIImageView()
    private let glowLayer: CAShapeLayer = CAShapeLayer()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            glowLayer.fillColor = UIColor.white.cgColor
            glowLayer.shadowOffset = .zero
            glowLayer.shadowColor = R.color.mainColour2()?.cgColor
            glowLayer.shadowRadius = 5
            glowLayer.shadowOpacity = 1
            glowLayer.path = UIBezierPath(rect: bounds).cgPath
            layer.insertSublayer(glowLayer, at: 0)

            weekdayLabel.textColor = R.color.mainColour1()
            temperatureLabel.textColor = R.color.mainColour1()
            weatherImageView.tintColor = R.color.mainColour1()
        } else {
            glowLayer.removeFromSuperlayer()

            weekdayLabel.textColor = .black
            temperatureLabel.textColor = .black
            weatherImageView.tintColor = .black
        }
    }

    // MARK: - Public

    func setup(with viewModel: DailyWeatherViewModel) {
        weekdayLabel.text = viewModel.weekday
        temperatureLabel.text = viewModel.temperature
        weatherImageView.image = viewModel.weatherImage?.withTintColor(.black, renderingMode: .alwaysTemplate)
    }

    // MARK: - Private

    private func setup() {
        self.separatorInset = UIEdgeInsets.zero
        self.selectionStyle = .none
        self.backgroundColor = .clear

        setupWeekdayLabel()
        setupTemperatureLabel()
        setupWeatherImageView()
    }

    private func setupWeekdayLabel() {
        weekdayLabel.textColor = .black
        weekdayLabel.font = .systemFont(ofSize: 18)

        addSubview(weekdayLabel)
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekdayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            weekdayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    private func setupTemperatureLabel() {
        temperatureLabel.textColor = .black
        temperatureLabel.font = .systemFont(ofSize: 18)

        addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    private func setupWeatherImageView() {
        weatherImageView.tintColor = .black
        weatherImageView.contentMode = .scaleAspectFit

        addSubview(weatherImageView)
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40),
            weatherImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
