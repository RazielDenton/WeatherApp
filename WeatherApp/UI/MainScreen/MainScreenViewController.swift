//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

protocol IMainScreenViewController: AnyObject {
    func reloadData()
}

final class MainScreenViewController: UIViewController, IMainScreenViewController {

    // Dependencies
    private let presenter: IMainScreenPresenter

    // UI elements
    private let mainScreenHeaderView: MainScreenHeaderView = MainScreenHeaderView()
    private let detailWeatherView: DetailWeatherView = DetailWeatherView()
    private let hourlyWeatherForecastView: HourlyWeatherForecastView = HourlyWeatherForecastView()
    private let dailyWeatherForecastView: DailyWeatherForecastView = DailyWeatherForecastView()

    // MARK: - Initialization

    init(presenter: IMainScreenPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWeatherViews()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Private

    private func setupWeatherViews() {
        self.view.addSubview(mainScreenHeaderView)
        self.view.addSubview(detailWeatherView)
        self.view.addSubview(hourlyWeatherForecastView)
        self.view.addSubview(dailyWeatherForecastView)

        mainScreenHeaderView.translatesAutoresizingMaskIntoConstraints = false
        detailWeatherView.translatesAutoresizingMaskIntoConstraints = false
        hourlyWeatherForecastView.translatesAutoresizingMaskIntoConstraints = false
        dailyWeatherForecastView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainScreenHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainScreenHeaderView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainScreenHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            detailWeatherView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailWeatherView.topAnchor.constraint(equalTo: mainScreenHeaderView.bottomAnchor),
            detailWeatherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailWeatherView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.3),

            hourlyWeatherForecastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hourlyWeatherForecastView.topAnchor.constraint(equalTo: detailWeatherView.bottomAnchor),
            hourlyWeatherForecastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hourlyWeatherForecastView.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.2),

            dailyWeatherForecastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            dailyWeatherForecastView.topAnchor.constraint(equalTo: self.hourlyWeatherForecastView.bottomAnchor),
            dailyWeatherForecastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            dailyWeatherForecastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    // MARK: - IMainScreenViewController

    func reloadData() {
        mainScreenHeaderView.setup(with: presenter.viewModel.mainScreenHeaderViewModel)
        detailWeatherView.setup(with: presenter.viewModel.detailWeatherViewModel)
        hourlyWeatherForecastView.setup(with: presenter.viewModel.hourlyWeatherViewModel)
        dailyWeatherForecastView.setup(with: presenter.viewModel.dailyWeatherViewModel)
    }
}
