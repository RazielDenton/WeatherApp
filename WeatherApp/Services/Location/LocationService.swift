//
//  LocationService.swift
//  WeatherApp
//
//  Created by Raziel on 06.03.2023.
//

import Combine
import CoreLocation

protocol ILocationService {
    var locationModelPublisher: Published<LocationModel?>.Publisher { get }
    func identifyUserLocation()
}

final class LocationService: NSObject, CLLocationManagerDelegate, ILocationService {

    // Properties
    @Published var locationModel: LocationModel?
    var locationModelPublisher: Published<LocationModel?>.Publisher { $locationModel }
    private lazy var locationManager: CLLocationManager = {
        let locationManager: CLLocationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self

        return locationManager
    }()

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        CLGeocoder().reverseGeocodeLocation(location) { [weak self] places, _ in
            guard let lastPlace = places?.last,
                  let cityName: String = lastPlace.locality,
                  let latitude = lastPlace.location?.coordinate.latitude,
                  let longitude = lastPlace.location?.coordinate.longitude else { return }

            self?.locationModel = LocationModel(cityName: cityName,
                                                latitude: latitude,
                                                longitude: longitude)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    // MARK: - IWeatherService

    func identifyUserLocation() {
        checkLocationAuthorization()
    }

    // MARK: - Private

    private func checkLocationAuthorization() {
        switch authorizationStatus() {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("parental control setting disallow location data")
        case .denied:
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    print("user tap 'disallow' on the permission dialog")
                } else {
                    print("location services are disabled")
                }
            }
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }

    private func authorizationStatus() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }

        return status
    }
}
