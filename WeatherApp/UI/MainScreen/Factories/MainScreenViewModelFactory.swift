//
//  MainScreenViewModelFactory.swift
//  WeatherApp
//
//  Created by Raziel on 05.03.2023.
//

import UIKit

protocol IMainScreenViewModelFactory {
    func makeViewModel(cityName: String?,
                       currentWeather: WeatherForecastData,
                       weatherForecast: [WeatherForecastData],
                       actions: MainScreenViewActions) -> MainScreenViewModel
}

final class MainScreenViewModelFactory: IMainScreenViewModelFactory {

    // MARK: - IMainScreenViewModelFactory

    func makeViewModel(cityName: String?,
                       currentWeather: WeatherForecastData,
                       weatherForecast: [WeatherForecastData],
                       actions: MainScreenViewActions) -> MainScreenViewModel {

        return .init(mainScreenHeaderViewModel: makeMainScreenHeaderViewModel(from: cityName, actions: actions),
                     detailWeatherViewModel: makeDetailWeatherViewModel(from: currentWeather),
                     hourlyWeatherViewModel: [],
                     dailyWeatherViewModel: [])
    }

    // MARK: - Private

    private func makeMainScreenHeaderViewModel(from data: String?, actions: MainScreenViewActions?) -> MainScreenHeaderViewModel {

        return .init(cityNameButtonImage: R.image.ic_place(),
                     cityName: data ?? "Оберіть місто",
                     locationButtonImage: R.image.ic_my_location(),
                     delegate: actions)
    }

    private func makeDetailWeatherViewModel(from data: WeatherForecastData) -> DetailWeatherViewModel {
        let date: Date = Date(timeIntervalSince1970: TimeInterval(data.timestamp))
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMMM"
        dateFormatter.shortWeekdaySymbols = dateFormatter.shortWeekdaySymbols.map { $0.uppercased() }
        let localDate: String = dateFormatter.string(from: date)

        var windDirection: UIImage?
        switch data.wind.deg {
        case 24...68:
            windDirection = R.image.icon_wind_ne()
        case 69...113:
            windDirection = R.image.icon_wind_e()
        case 114...158:
            windDirection = R.image.icon_wind_se()
        case 159...203:
            windDirection = R.image.icon_wind_s()
        case 204...248:
            windDirection = R.image.icon_wind_ws()
        case 249...293:
            windDirection = R.image.icon_wind_w()
        case 294...338:
            windDirection = R.image.icon_wind_wn()
        default:
            windDirection = R.image.icon_wind_n()
        }

        return .init(date: localDate,
                     weatherImage: R.image.ic_white_day_cloudy(),
                     temperatureImage: R.image.ic_temp(),
                     temperature: "\(data.minTemp)°/ \(data.maxTemp)°",
                     humidityImage: R.image.ic_humidity(),
                     humidity: "\(data.humidity)%",
                     windImage: R.image.ic_wind(),
                     windSpeed: "\(Int(data.wind.speed.rounded()))м/сек",
                     windDirection: windDirection)
    }
}
