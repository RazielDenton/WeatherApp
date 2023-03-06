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
                     hourlyWeatherViewModel: makeHourlyWeatherViewModel(from: weatherForecast),
                     dailyWeatherViewModel: makeDailyWeatherViewModel(from: weatherForecast, actions: actions))
    }

    // MARK: - Private

    private func makeMainScreenHeaderViewModel(from data: String?, actions: MainScreenViewActions?) -> MainScreenHeaderViewModel {

        return .init(cityNameButtonImage: R.image.ic_place(),
                     cityName: data ?? "Київ",
                     locationButtonImage: R.image.ic_my_location(),
                     delegate: actions)
    }

    private func makeDetailWeatherViewModel(from data: WeatherForecastData) -> DetailWeatherViewModel {
        let date: Date = Date(timeIntervalSince1970: TimeInterval(data.timestamp))
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMMM"
        dateFormatter.shortWeekdaySymbols = dateFormatter.shortWeekdaySymbols.map { $0.uppercased() }
        let localDate: String = dateFormatter.string(from: date)

        return .init(date: localDate,
                     weatherImage: getWeatherImage(date: date, conditionCode: data.weatherConditionCode),
                     temperatureImage: R.image.ic_temp(),
                     temperature: "\(data.minTemp)°/ \(data.maxTemp)°",
                     humidityImage: R.image.ic_humidity(),
                     humidity: "\(data.humidity)%",
                     windImage: R.image.ic_wind(),
                     windSpeed: "\(Int(data.wind.speed.rounded()))м/сек",
                     windDirection: getWindDirection(for: data.wind.deg))
    }

    private func makeHourlyWeatherViewModel(from data: [WeatherForecastData]) -> [HourlyWeatherViewModel] {
        let tomorrow: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        let hourlyWeatherForecastData: [WeatherForecastData] = data.filter {
            $0.timestamp <= Int(tomorrow.timeIntervalSince1970)
        }

        return hourlyWeatherForecastData.map { model in
            let date: Date = Date(timeIntervalSince1970: TimeInterval(model.timestamp))
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            let localDate: String = dateFormatter.string(from: date)

            return HourlyWeatherViewModel(time: localDate + "\u{2070}\u{2070}",
                                          weatherImage: getWeatherImage(date: date, conditionCode: model.weatherConditionCode),
                                          temperature: "\(model.temperature)°")
        }
    }

    private func makeDailyWeatherViewModel(from data: [WeatherForecastData], actions: MainScreenViewActions) -> [DailyWeatherViewModel] {
        let dailyWeatherForecastData: [WeatherForecastData] = data.filter {
            let date: Date = Date(timeIntervalSince1970: TimeInterval($0.timestamp))
            return Calendar.current.component(.hour, from: date) == 14
        }

        return dailyWeatherForecastData.map { model in
            let date: Date = Date(timeIntervalSince1970: TimeInterval(model.timestamp))
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E"
            dateFormatter.shortWeekdaySymbols = dateFormatter.shortWeekdaySymbols.map { $0.uppercased() }
            let localDate: String = dateFormatter.string(from: date)

            return DailyWeatherViewModel(weekday: localDate,
                                         temperature: "\(model.minTemp)°/ \(model.maxTemp)°",
                                         weatherImage: getWeatherImage(date: date, conditionCode: model.weatherConditionCode),
                                         tapAction: { [weak actions] in
                actions?.didTapDayForecastCell()
            })
        }
    }

    private func getWindDirection(for windDeg: Int) -> UIImage? {
        switch windDeg {
        case 24...68:
            return R.image.icon_wind_ne()
        case 69...113:
            return R.image.icon_wind_e()
        case 114...158:
            return R.image.icon_wind_se()
        case 159...203:
            return R.image.icon_wind_s()
        case 204...248:
            return R.image.icon_wind_ws()
        case 249...293:
            return R.image.icon_wind_w()
        case 294...338:
            return R.image.icon_wind_wn()
        default:
            return R.image.icon_wind_n()
        }
    }

    private func getWeatherImage(date: Date, conditionCode: Int) -> UIImage? {
        let currentHour: Int = Calendar.current.component(.hour, from: date)
        let isNight: Bool = currentHour >= 22 || currentHour < 6

        switch conditionCode {
        case 200...299:
            if isNight {
                return R.image.ic_white_night_thunder()
            } else {
                return R.image.ic_white_day_thunder()
            }
        case 300...399:
            if isNight {
                return R.image.ic_white_night_rain()
            } else {
                return R.image.ic_white_day_rain()
            }
        case 500...599:
            if isNight {
                return R.image.ic_white_night_shower()
            } else {
                return R.image.ic_white_day_shower()
            }
        case 600...699:
            return .init(systemName: "snow")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case 700...799:
            return .init(systemName: "cloud.fog")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case 800:
            if isNight {
                return R.image.ic_white_night_bright()
            } else {
                return R.image.ic_white_day_bright()
            }
        case 801...804:
            if isNight {
                return R.image.ic_white_night_cloudy()
            } else {
                return R.image.ic_white_day_cloudy()
            }
        default:
            return nil
        }
    }
}
