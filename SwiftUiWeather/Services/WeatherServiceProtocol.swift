//
//  WeatherServiceProtocol.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 15/10/2024.
//


import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error>
    func getWeather(for city: String) async throws -> WeatherResponse
}

class WeatherService: WeatherServiceProtocol {
    
    
    private let apiKey: String 

    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "\(baseURL)?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else {
                    let statusCode = (result.response as? HTTPURLResponse)?.statusCode ?? -1
                    throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "Server returned status code \(statusCode)"])
                }
                return result.data
            }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    @MainActor
    func getWeather(for city: String) async throws -> WeatherResponse{
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "\(baseURL)?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}
