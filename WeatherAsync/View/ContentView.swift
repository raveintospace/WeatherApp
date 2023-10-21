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
    @State private var showAlert = false
    @State private var location = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text(viewModel.weatherModelForView.city)
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                        .multilineTextAlignment(.center)
                    Text(viewModel.weatherModelForView.description.capitalizingFirstLetter())
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    imageAndTemperature
                    minMaxTemperature
                    customDivider
                    humidity
                    customDivider
                    sunriseAndSunset
                    Spacer()
                }
                .padding(.top, 20)
            }
            .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .task {
                await viewModel.getWeather(city: "Palafrugell")
            }
            
            if viewModel.noLocationAlert {
                noLocationWarning
            }
        }
        .searchable(text: $location, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Enter location"))
        .autocorrectionDisabled()
        .onSubmit(of: .search, getWeather)
    }
    
    var imageAndTemperature: some View {
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
    }
    
    var minMaxTemperature: some View {
        HStack(spacing: 14) {
            Label(viewModel.weatherModelForView.minTemperature, systemImage: "thermometer.snowflake")
            Label(viewModel.weatherModelForView.maxTemperature, systemImage: "thermometer.sun.fill")
        }
        .modifier(CustomModifier())
    }
    
    var customDivider: some View {
        Divider()
            .foregroundColor(.white)
            .padding()
    }
    
    var humidity: some View {
        VStack {
            Label(viewModel.weatherModelForView.humidity, systemImage: "humidity.fill")
                .modifier(CustomModifier())
        }
    }
    
    var sunriseAndSunset: some View {
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
        .padding(.top, 5)
    }
    
    var noLocationWarning: some View {
        Button(action: {
            showAlert = true
        }, label: {
            Text("Error                                          ")
        })
        .padding(.top, 10)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.purple)
        .alert(isPresented: $showAlert, content: {
            return Alert(
                title: Text("Unavailable location ❌ \n Please enter another one 🙂"),
                dismissButton: .default(Text("OK"), action: {
                    location = ""
                }))
        })
    }
    
    func getWeather() {
        Task {
            await viewModel.getWeather(city: location)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
