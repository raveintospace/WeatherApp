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
    
    func fetch<T: Decodable>(city: String) async throws -> T {
        
        // check if url exists
//        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a0f83ddbf9fa0d41abe53f5ea148d5fe&units=metric&lang=es") else { throw RemoteDataSourceError.invalidURL }
        guard let url = createURL(city: city) else { throw RemoteDataSourceError.invalidURL }
        
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
        var queryItems = [URLQueryItem(name: "q", value: city)]
                          
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}
