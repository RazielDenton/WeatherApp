//
//  DailyWeatherForecastView.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

class DailyWeatherForecastView: UIView, UITableViewDataSource, UITableViewDelegate {

    // Properties
    private var viewModel: [DailyWeatherViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // UI elements
    private let tableView: UITableView = UITableView()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setup(with viewModel: [DailyWeatherViewModel]) {
        self.viewModel = viewModel
    }

    // MARK: - Private

    private func setup() {
        self.backgroundColor = .white

        setupTableView()
    }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DailyWeatherForecastCell.self, forCellReuseIdentifier: "DailyWeatherForecastCell")
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "DailyWeatherForecastCell", for: indexPath)

        if let cell: DailyWeatherForecastCell = cell as? DailyWeatherForecastCell {
            cell.setup(with: viewModel[indexPath.row])
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel[indexPath.row].tapAction()
    }
}
