//
//  MapScreenViewController.swift
//  WeatherApp
//
//  Created by Raziel on 06.03.2023.
//

import MapKit
import Combine

class MapScreenViewController: UIViewController {

    // Dependencies
    weak var delegate: MapViewActions?
    private let locationService: ILocationService

    // Properties
    private var selectedCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    private var cancellables: Set<AnyCancellable> = []

    // UI elements
    private let mapView: MKMapView = MKMapView()
    private let cityDefinitionView: UIView = UIView()
    private let cityLabel: UILabel = UILabel()
    private let checkButton: UIButton = UIButton(type: .system)

    // MARK: - Initialization

    init(delegate: MapViewActions, locationService: ILocationService) {
        self.delegate = delegate
        self.locationService = locationService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        setupLocationObserver()
        setupCityDefinitionView()
        setupCityLabel()
        setupCheckButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Private

    private func setupMapView() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped))
        mapView.addGestureRecognizer(tapGesture)

        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    private func setupLocationObserver() {
        locationService.locationModelPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locationModel in
                guard let location: LocationModel = locationModel else { return }
                let region: MKCoordinateRegion = .init(center: .init(latitude: location.latitude, longitude: location.longitude),
                                                       latitudinalMeters: 90000, longitudinalMeters: 90000)
                self?.mapView.setRegion(region, animated: true)
                self?.mapView.showsUserLocation = true
            }.store(in: &cancellables)
    }

    private func setupCityDefinitionView() {
        cityDefinitionView.backgroundColor = .white
        cityDefinitionView.layer.cornerRadius = 20
        cityDefinitionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        self.view.addSubview(cityDefinitionView)
        cityDefinitionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityDefinitionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cityDefinitionView.heightAnchor.constraint(equalToConstant: 100),
            cityDefinitionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cityDefinitionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    private func setupCityLabel() {
        cityLabel.text = "Оберіть місто"
        cityLabel.font = .systemFont(ofSize: 26)

        self.view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: cityDefinitionView.leadingAnchor, constant: 30),
            cityLabel.topAnchor.constraint(equalTo: cityDefinitionView.topAnchor, constant: 20)
        ])
    }

    private func setupCheckButton() {
        let configuration: UIImage.SymbolConfiguration = .init(pointSize: 30)
        let image: UIImage? = .init(systemName: "checkmark.circle", withConfiguration: configuration)
        checkButton.setImage(image, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)

        self.view.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkButton.trailingAnchor.constraint(equalTo: cityDefinitionView.trailingAnchor, constant: -20),
            checkButton.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            checkButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Actions

    @objc func mapViewTapped(gestureReconizer: UITapGestureRecognizer) {
        let pointAnnotations: [MKPointAnnotation] = mapView.annotations.compactMap { $0 as? MKPointAnnotation }
        if pointAnnotations.count >= 1 {
            mapView.removeAnnotations(pointAnnotations)
        }

        let location: CGPoint = gestureReconizer.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)

        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude,
                                                       longitude: coordinate.longitude)) { [weak self] places, _ in
            guard let lastPlace = places?.last,
                  let cityName = lastPlace.locality else { return }
            self?.cityLabel.text = cityName
            self?.selectedCoordinate = coordinate
        }

        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }

    @objc func checkButtonTapped() {
        guard let cityName = cityLabel.text else { return }

        delegate?.citySelected(location: LocationModel(cityName: cityName,
                                                       latitude: selectedCoordinate.latitude,
                                                       longitude: selectedCoordinate.longitude))

        navigationController?.popViewController(animated: true)
    }
}
