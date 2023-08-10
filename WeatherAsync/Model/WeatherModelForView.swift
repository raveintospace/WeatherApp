//
//  WeatherModelForView.swift
//  WeatherAsync
//
//  Created by Uri on 10/8/23.
//

import Foundation

struct WeatherModelForView {
    let city: String
    let weather: String
    let description: String
    let iconURL: URL?
    let currentTemperature: String
    let minTemperature: String
    let maxTemperature: String
    let humidity: String
    let sunrise: Date
    let sunset: Date
    
    // empty model to avoid optionals, appears when app is fetching data
    static let empty: WeatherModelForView = .init(city: "No city",
                                                  weather: "No weather",
                                                  description: "No description",
                                                  iconURL: nil,
                                                  currentTemperature: "0º",
                                                  minTemperature: "0º",
                                                  maxTemperature: "0º",
                                                  humidity: "0%",
                                                  sunrise: .now,
                                                  sunset: .now)
}
