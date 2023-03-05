//
//  MainScreenHeaderView.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

class MainScreenHeaderView: UIView {

    // Dependencies
    private weak var delegate: MainScreenViewActions?

    // UI elements
    private let cityNameButton: UIButton = UIButton(type: .system)
    private let locationButton: UIButton = UIButton(type: .system)

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setup(with viewModel: MainScreenHeaderViewModel) {
        cityNameButton.setImage(viewModel.cityNameButtonImage, for: .normal)
        cityNameButton.setTitle(viewModel.cityName, for: .normal)
        locationButton.setImage(viewModel.locationButtonImage, for: .normal)
        delegate = viewModel.delegate
    }

    // MARK: - Private

    private func setup() {
        self.backgroundColor = R.color.mainColour1()

        setupCityNameButton()
        setupLocationButton()
    }

    private func setupCityNameButton() {
        cityNameButton.tintColor = .white
        cityNameButton.imageEdgeInsets.left = -10
        cityNameButton.setTitleColor(.white, for: .normal)
        cityNameButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        cityNameButton.addTarget(self, action: #selector(cityNameButtonTapped), for: .touchUpInside)

        self.addSubview(cityNameButton)
        cityNameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityNameButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            cityNameButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            cityNameButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupLocationButton() {
        locationButton.tintColor = .white
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)

        self.addSubview(locationButton)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            locationButton.centerYAnchor.constraint(equalTo: cityNameButton.centerYAnchor)
        ])
    }

    // MARK: - Actions

    @objc func cityNameButtonTapped() {
        delegate?.didTapPickLocation()
    }

    @objc func locationButtonTapped() {
        delegate?.didTapMyLocation()
    }
}
