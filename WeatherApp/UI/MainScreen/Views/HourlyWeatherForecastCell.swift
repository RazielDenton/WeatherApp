//
//  HourlyWeatherForecastCell.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

final class HourlyWeatherForecastCell: UICollectionViewCell {

    // UI elements
    private let timeLabel: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    private let tempLabel: UILabel = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    static func size(for size: CGSize, interitemSpacing: CGFloat) -> CGSize {
        let cellOnPage: CGFloat = 4
        let visiblePart: CGFloat = 0.6

        let availableWidth: CGFloat = size.width - cellOnPage * interitemSpacing
        let width: CGFloat = availableWidth / (cellOnPage + visiblePart)
        let height: CGFloat = size.height

        return .init(width: width, height: height)
    }

    func setup(with viewModel: HourlyWeatherViewModel) {
        timeLabel.text = viewModel.time
        imageView.image = viewModel.weatherImage
        tempLabel.text = viewModel.temperature
    }

    // MARK: - Private

    private func setup() {
        setupImageView()
        setupTimeLabel()
        setupTempLabel()
    }

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit

        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupTimeLabel() {
        timeLabel.textColor = .white
        timeLabel.font = .systemFont(ofSize: 18)

        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -25),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    private func setupTempLabel() {
        tempLabel.textColor = .white
        tempLabel.font = .systemFont(ofSize: 18)

        contentView.addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
