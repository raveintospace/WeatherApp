//
//  RemoteDataSource.swift
//  WeatherAsync
//
//  Created by Uri on 10/8/23.
//

import Foundation

enum RemoteDataSourceError: Error {
    case invalidURL
    case parsing
}

struct RemoteDataSource {
    
    // not used with the generic network manager
    func fetchWeather(city: String) async throws -> WeatherResponseDataModel {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=/*insert your api key*/&units=metric&lang=es") else { throw RemoteDataSourceError.invalidURL }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            return dataModel
        
        } catch {
            throw RemoteDataSourceError.parsing
        }
    }
    
    func fetch<T: Decodable>(type: T.Type, url: URL?) async throws -> T {
        
        // check if url exists
        guard let url = url else {
            throw RemoteDataSourceError.invalidURL
        }
        
        // obtain data & response from url
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // check if response returns 200
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // decode data into our model object
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
    
    func createURL(city: String) -> URL? {
        
        let baseURL = "http://api.openweathermap.org/data/2.5/weather"
        let queryItems = [URLQueryItem(name: "q", value: city),
                          URLQueryItem(name: "appid", value: /*insert your api key*/),
                          URLQueryItem(name: "units", value: "metric"),
                          URLQueryItem(name: "lang", value: "es")]
                          
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func fetchWeatherInfo(city: String) async throws -> WeatherResponseDataModel {
        
        let url = createURL(city: city)
        
        return try await fetch(type: WeatherResponseDataModel.self, url: url)
    }
}
