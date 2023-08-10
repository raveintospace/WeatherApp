//
//  WeatherViewModel.swift
//  WeatherAsync
//
//  Created by Uri on 9/8/23.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var weatherModelForView: WeatherModelForView = .empty
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    
    func getWeather(city: String) async {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a0f83ddbf9fa0d41abe53f5ea148d5fe&units=metric&lang=es")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.weatherModelForView = self.weatherModelMapper.mapDataModelToModel(dataModel: dataModel)
            }
            debugPrint(dataModel)
            
        } catch {
            print(error)
        }
    }
}
