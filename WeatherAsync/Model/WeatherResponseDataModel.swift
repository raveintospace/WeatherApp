//
//  WeatherResponseDataModel.swift
//  WeatherAsync
//
//  Created by Uri on 9/8/23.
//

import Foundation

struct WeatherResponseDataModel: Decodable {
    let city: String
    let weather: [WeatherDataModel]
    let temperature: TemperatureDataModel
    let sun: SunModel
    let timezone: Double
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case weather, timezone
        case temperature = "main"
        case sun = "sys"
    }
}

struct WeatherDataModel: Decodable {
    let main: String
    let description: String
    let iconURLString: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
        case iconURLString = "icon"
    }
}

struct TemperatureDataModel: Decodable {
    let currentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
}

struct SunModel: Decodable {
    let sunrise: Date
    let sunset: Date
}

/*
{
 "coord":{
 "lon":2.159,
 "lat":41.3888
 },
 
 "weather":[
 {"id":801,
 "main":"Clouds",
 "description":"algo de nubes",
 "icon":"02d"
 }
 ],
 
 "base":"stations",
 "main":{
 "temp":29.61,
 "feels_like":34.78,
 "temp_min":27.61,
 "temp_max":34.89,
 "pressure":1017,
 "humidity":73},
 "visibility":10000,
 "wind":{
 "speed":7.72,
 "deg":210
 },
 "clouds":{
 "all":20
 },
 "dt":1691594967,
 "sys":{
 "type":2,
 "id":18549,
 "country":"ES",
 "sunrise":1691556832,
 "sunset":1691607604
 },
 "timezone":7200,
 "id":3128760,
 "name":"Barcelona",
 "cod":200
 }
*/

