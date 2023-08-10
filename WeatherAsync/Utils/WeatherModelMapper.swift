//
//  WeatherModelMapper.swift
//  WeatherAsync
//
//  Created by Uri on 10/8/23.
//

import Foundation

struct WeatherModelMapper {
    func mapDataModelToModel(dataModel: WeatherResponseDataModel) -> WeatherModelForView {
        guard let weather = dataModel.weather.first else { return .empty}
        
        let temperature = dataModel.temperature
        
        let sunriseWithTimezone = dataModel.sun.sunrise.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        let sunsetWithTimezone = dataModel.sun.sunset.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        return WeatherModelForView(city: dataModel.city,
                                   weather: weather.main,
                                   description: "\(weather.description)",
                                   iconURL: URL(string: "http://openweathermap.org/img/wn/\(weather.iconURLString)@2x.png"),
                                   currentTemperature: "\(Int(temperature.currentTemperature))º",
                                   minTemperature: "\(Int(temperature.minTemperature))º Min.",
                                   maxTemperature: "\(Int(temperature.maxTemperature))º Max.",
                                   humidity: "\(Int(temperature.humidity))%",
                                   sunrise: sunriseWithTimezone,
                                   sunset: sunsetWithTimezone)
    }
}
