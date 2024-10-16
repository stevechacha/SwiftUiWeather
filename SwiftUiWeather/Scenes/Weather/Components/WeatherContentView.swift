//
//  WeatherContentView.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 16/10/2024.
//

import SwiftUI

struct WeatherContentView: View {
    let weather: WeatherResponse
    
    var body: some View {
        VStack(spacing: 20) {
            Text(weather.name)
                .font(.largeTitle)
                .bold()
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            
            Text("\(Int(weather.main.temp))°C")
                .font(.system(size: 64))
                .bold()
            
            Text(weather.weather.first?.description.capitalized ?? "")
                .font(.title2)
                .foregroundColor(.gray)
            
            HStack(spacing: 40) {
                VStack {
                    Image(systemName: "thermometer")
                        .font(.title)
                        .foregroundColor(.orange)
                    Text("Feels like \(Int(weather.main.feels_like))°C")
                        .font(.subheadline)
                }
                VStack {
                    Image(systemName: "humidity")
                        .font(.title)
                        .foregroundColor(.blue)
                    Text("Humidity \(weather.main.humidity)%")
                        .font(.subheadline)
                }
            }
            .padding(.top, 20)
        }
    }
}
