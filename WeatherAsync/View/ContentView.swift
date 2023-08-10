//
//  ContentView.swift
//  WeatherAsync
//  API key a0f83ddbf9fa0d41abe53f5ea148d5fe
//  https://youtu.be/-LKTrSZnVms
//  Created by Uri on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.weatherModelForView.city)
                    .foregroundColor(.white)
                    .font(.system(size: 70))
                Text(viewModel.weatherModelForView.description)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                HStack {
                    if let url = viewModel.weatherModelForView.iconURL {
                        AsyncImage(url: url) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }

                    }
                    Text(viewModel.weatherModelForView.currentTemperature)
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                }
                .padding(.top, -20)
                HStack(spacing: 14) {
                    Label(viewModel.weatherModelForView.minTemperature, systemImage: "thermometer.snowflake")
                    Label(viewModel.weatherModelForView.maxTemperature, systemImage: "thermometer.sun.fill")
                }
                .modifier(CustomModifier())
                
                Divider()
                    .foregroundColor(.white)
                    .padding()
                
                HStack(spacing: 32) {
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(viewModel.weatherModelForView.sunrise, style: .time)
                    }
                    
                    VStack {
                        Image(systemName: "sunset.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(viewModel.weatherModelForView.sunset, style: .time)
                    }
                }
                .foregroundColor(.white)
                
                Divider()
                    .foregroundColor(.white)
                    .padding()
                
                Label(viewModel.weatherModelForView.humidity, systemImage: "humidity.fill")
                    .modifier(CustomModifier())
                Spacer()
            }
            .padding(.top, 20)
        }
        .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .task {
            await viewModel.getWeather(city: "Palafrugell")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
