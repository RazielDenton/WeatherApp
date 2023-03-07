//
//  SearchCityCell.swift
//  WeatherApp
//
//  Created by Raziel on 07.03.2023.
//

import UIKit

final class SearchCityCell: UITableViewCell {

    // UI elements
    private let cityLabel: UILabel = UILabel()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setup(with viewModel: SearchCityViewModel) {
        cityLabel.text = viewModel.cityName
    }

    // MARK: - Private

    private func setup() {
        self.separatorInset = UIEdgeInsets.zero

        setupCityLabel()
    }

    private func setupCityLabel() {
        cityLabel.textColor = .black
        cityLabel.font = .systemFont(ofSize: 18)

        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
