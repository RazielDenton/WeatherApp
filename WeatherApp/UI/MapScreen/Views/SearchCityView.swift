//
//  SearchCityView.swift
//  WeatherApp
//
//  Created by Raziel on 07.03.2023.
//

import UIKit

class SearchCityView: UIView, UITableViewDataSource, UITableViewDelegate {

    // Dependencies
    weak var delegate: IMapScreenViewController?

    // Properties
    private var viewModel: [SearchCityViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // UI elements
    private let searchTextField: UITextField = UITextField()
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

    func setup(with viewModel: [SearchCityViewModel]) {
        self.viewModel = viewModel
    }

    // MARK: - Private

    private func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        setupSearchTextField()
        setupTableView()
    }

    private func setupSearchTextField() {
        searchTextField.borderStyle = .bezel
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        self.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchTextField.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 36)
        ])
    }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchCityCell.self, forCellReuseIdentifier: "SearchCityCell")
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }

        delegate?.search(text: text)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "SearchCityCell", for: indexPath)

        if let cell: SearchCityCell = cell as? SearchCityCell {
            cell.setup(with: viewModel[indexPath.row])
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel[indexPath.row].tapAction()
    }
}
