//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

struct DarkSkyWeatherData: Codable {
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently?
//    let hourly: Hourly
    let daily: Daily
//    let flags: Flags
    let offset: Int
}

// MARK: - Currently
struct Currently: Codable {
    let time: Int
    let summary: String
    let icon: Icon
    let nearestStormDistance, nearestStormBearing: Int?
    let precipIntensity, precipProbability, temperature, apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double?
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility, ozone: Double
    let precipType: String?
    let precipAccumulation: Double?
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}



// MARK: - Daily
struct Daily: Codable {
    let summary, icon: String
    let data: [DailyDatum]
}

// MARK: - DailyDatum
struct DailyDatum: Codable {
    let time: Int
    let summary, icon: String
    let sunriseTime, sunsetTime: Int
    let moonPhase, precipIntensity, precipIntensityMax: Double
    let precipIntensityMaxTime: Int
    let precipProbability: Double
    let precipType: String?
    let precipAccumulation: Double?
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windGustTime, windBearing: Int
    let cloudCover: Double
    let uvIndex, uvIndexTime: Int
    let visibility, ozone, temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}
