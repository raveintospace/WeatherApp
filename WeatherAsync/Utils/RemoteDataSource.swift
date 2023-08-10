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
    func fetchWeather(city: String) async throws -> WeatherResponseDataModel {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a0f83ddbf9fa0d41abe53f5ea148d5fe&units=metric&lang=es") else { throw RemoteDataSourceError.invalidURL }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            return dataModel
        
        } catch {
            throw RemoteDataSourceError.parsing
        }
    }
}
