//
//  WeatherViewModel.swift
//  WeatherAsync
//
//  Created by Uri on 9/8/23.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var weatherModelForView: WeatherModelForView
    @Published var noLocationAlert: Bool
    @Published var receivedWeather: WeatherResponseDataModel? = nil
    
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    private let repository: RemoteDataSource
    
    
    init(noLocation: Bool = false, weatherModelForView: WeatherModelForView = .empty, repository: RemoteDataSource = RemoteDataSource()) {
        self.noLocationAlert = noLocation
        self.weatherModelForView = weatherModelForView
        self.repository = repository
    }

    @MainActor
    func getWeather(city: String) async {
        do {
            receivedWeather = try await repository.fetchWeatherInfo(city: city)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.weatherModelForView = self.weatherModelMapper.mapDataModelToModel(dataModel: receivedWeather ?? WeatherResponseDataModel.empty)
                self.noLocationAlert = false
            }
        }
        catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.noLocationAlert = true
            }
        }
    }
}
