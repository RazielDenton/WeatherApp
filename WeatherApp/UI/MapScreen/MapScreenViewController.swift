//
//  MapScreenViewController.swift
//  WeatherApp
//
//  Created by Raziel on 06.03.2023.
//

import MapKit
import Combine

protocol IMapScreenViewController: AnyObject {
    func search(text: String)
}

class MapScreenViewController: UIViewController, IMapScreenViewController {

    // Dependencies
    weak var delegate: MapViewActions?
    private var locationService: ILocationService

    // Properties
    private var selectedCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    private var cancellables: Set<AnyCancellable> = []
    private let searchViewHeight: CGFloat = UIScreen.main.bounds.height * 0.4

    // UI elements
    private let mapView: MKMapView = MKMapView()
    private let cityDefinitionView: UIView = UIView()
    private let cityLabel: UILabel = UILabel()
    private let checkButton: UIButton = UIButton(type: .system)

    private let searchView: UIView = UIView()
    private let searchCityView: SearchCityView = SearchCityView()
    private var searchViewHeightConstraint: NSLayoutConstraint?
    private var searchViewBottomConstraint: NSLayoutConstraint?

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
        setupSearchResultsObserver()
        setupCityDefinitionView()
        setupCityLabel()
        setupCheckButton()
        setupSearch()
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

    private func setupSearchResultsObserver() {
        locationService.setupSearchObserver()

        locationService.searchResultsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchResults in
                let searchCityViewModel: [SearchCityViewModel] = searchResults.map { SearchCityViewModel(cityName: $0.title) {
                    print("convert row address data into the coordinates using MKLocalSearch request")
                } }
                self?.searchCityView.setup(with: searchCityViewModel)
            }.store(in: &cancellables)
    }

    private func setupSearch() {
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.ic_search(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonTapped))

        searchView.backgroundColor = .white
        searchView.layer.cornerRadius = 20
        searchView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        self.view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        searchViewHeightConstraint = searchView.heightAnchor.constraint(equalToConstant: searchViewHeight)
        searchViewBottomConstraint = searchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: searchViewHeight)

        searchViewHeightConstraint?.isActive = true
        searchViewBottomConstraint?.isActive = true

        searchCityView.delegate = self

        searchView.addSubview(searchCityView)
        searchCityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchCityView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchCityView.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchCityView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor),
            searchCityView.bottomAnchor.constraint(equalTo: searchView.bottomAnchor)
        ])
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

    private func animateSearchViewPresence() {
        let damping: CGFloat = 0.8
        let response: CGFloat = 0.3
        let springParameters: UISpringTimingParameters = UISpringTimingParameters(
            mass: 1.0,
            stiffness: pow(2 * .pi / response, 2),
            damping: 4 * .pi * damping / response,
            initialVelocity: .zero
        )
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0, timingParameters: springParameters)
        animator.addAnimations {
            self.searchViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }

    private func animateSearchViewHiding() {
        UIView.animate(withDuration: 0.3) {
            self.searchViewBottomConstraint?.constant = self.searchViewHeight
            self.view.layoutIfNeeded()
        }
    }

    private func animateSearchHeight() {
        let damping: CGFloat = 0.7
        let response: CGFloat = 0.2
        let springParameters: UISpringTimingParameters = UISpringTimingParameters(
            mass: 1.0,
            stiffness: pow(2 * .pi / response, 2),
            damping: 4 * .pi * damping / response,
            initialVelocity: .zero
        )
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0, timingParameters: springParameters)
        animator.addAnimations {
            self.searchViewBottomConstraint?.constant = 0
            self.searchViewHeightConstraint?.constant = self.searchViewHeight
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
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

    @objc func searchButtonTapped() {
        animateSearchViewPresence()
    }

    @objc func checkButtonTapped() {
        guard let cityName = cityLabel.text else { return }

        delegate?.citySelected(location: LocationModel(cityName: cityName,
                                                       latitude: selectedCoordinate.latitude,
                                                       longitude: selectedCoordinate.longitude))

        navigationController?.popViewController(animated: true)
    }

    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation: CGPoint = gesture.translation(in: view)

        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                searchViewBottomConstraint?.constant = translation.y
            } else {
                let anotherHeight: CGFloat = searchViewHeight - (translation.y * 0.1)
                searchViewHeightConstraint?.constant = anotherHeight
            }
            view.layoutIfNeeded()
        case .ended:
            if translation.y > searchViewHeight * 0.3 {
                animateSearchViewHiding()
            } else {
                animateSearchHeight()
            }
        default:
            break
        }
    }

    // MARK: - IMapScreenViewController

    func search(text: String) {
        locationService.searchQuery = text
    }
}
