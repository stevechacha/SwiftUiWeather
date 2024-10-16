//
//  WeatherResponse.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 15/10/2024.
//


struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
}
