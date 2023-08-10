//
//  WeatherViewModel.swift
//  WeatherAsync
//
//  Created by Uri on 9/8/23.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var weatherModelForView: WeatherModelForView
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    private let repository: RemoteDataSource
    
    init(weatherModelForView: WeatherModelForView = .empty, repository: RemoteDataSource = RemoteDataSource()) {
        self.weatherModelForView = weatherModelForView
        self.repository = repository
    }

    func getWeather(city: String) async {
        do {
            let receivedWeather = try await repository.fetchWeather(city: city)
            self.weatherModelForView = self.weatherModelMapper.mapDataModelToModel(dataModel: receivedWeather)
        }
        catch {
            print(error)
        }
    }
}
