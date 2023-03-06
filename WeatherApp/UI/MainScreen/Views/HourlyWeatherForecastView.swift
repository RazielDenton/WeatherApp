//
//  HourlyWeatherForecastView.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

class HourlyWeatherForecastView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Properties
    private let interitemSpacing: CGFloat = 10
    private var viewModel: [HourlyWeatherViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // UI elements
    private let collectionViewLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setup(with viewModel: [HourlyWeatherViewModel]) {
        self.viewModel = viewModel
    }

    // MARK: - Private

    private func setup() {
        self.backgroundColor = R.color.mainColour2()

        setupCollectionViewLayout()
        setupCollectionView()
    }

    private func setupCollectionViewLayout() {
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = interitemSpacing
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = false
        collectionView.backgroundColor = nil
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HourlyWeatherForecastCell.self, forCellWithReuseIdentifier: "HourlyWeatherForecastCell")

        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherForecastCell", for: indexPath)

        if let cell: HourlyWeatherForecastCell = cell as? HourlyWeatherForecastCell {
            cell.setup(with: viewModel[indexPath.row])
        }

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        HourlyWeatherForecastCell.size(for: collectionView.frame.size,
                                       interitemSpacing: interitemSpacing)
    }
}
