//
//  MainScreenViewModel.swift
//  WeatherApp
//
//  Created by Raziel on 05.03.2023.
//

import UIKit

struct MainScreenViewModel {
    static let empty: MainScreenViewModel = MainScreenViewModel(
        mainScreenHeaderViewModel: MainScreenHeaderViewModel(cityNameButtonImage: nil,
                                                             cityName: "",
                                                             locationButtonImage: nil,
                                                             delegate: nil),
        detailWeatherViewModel: DetailWeatherViewModel(date: "",
                                                       weatherImage: nil,
                                                       temperatureImage: nil,
                                                       temperature: "",
                                                       humidityImage: nil,
                                                       humidity: "",
                                                       windImage: nil,
                                                       windSpeed: "",
                                                       windDirection: nil),
        hourlyWeatherViewModel: [],
        dailyWeatherViewModel: []
    )

    let mainScreenHeaderViewModel: MainScreenHeaderViewModel
    let detailWeatherViewModel: DetailWeatherViewModel
    let hourlyWeatherViewModel: [HourlyWeatherViewModel]
    let dailyWeatherViewModel: [DailyWeatherViewModel]
}

struct MainScreenHeaderViewModel {
    let cityNameButtonImage: UIImage?
    let cityName: String
    let locationButtonImage: UIImage?
    let delegate: MainScreenViewActions?
}

struct DetailWeatherViewModel {
    let date: String
    let weatherImage: UIImage?
    let temperatureImage: UIImage?
    let temperature: String
    let humidityImage: UIImage?
    let humidity: String
    let windImage: UIImage?
    let windSpeed: String
    let windDirection: UIImage?
}

struct HourlyWeatherViewModel {
    let time: String
    let weatherImage: UIImage?
    let temperature: String
}

struct DailyWeatherViewModel {
    let weekday: String
    let temperature: String
    let weatherImage: UIImage?
    let tapAction: () -> Void
}
