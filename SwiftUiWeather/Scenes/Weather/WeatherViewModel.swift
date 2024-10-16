//
//  WeatherViewModel.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 15/10/2024.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private let apiKey = "f9258332a457d9c986a91eb20bbda7cf"
    
    private var weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol = WeatherService(apiKey: "f9258332a457d9c986a91eb20bbda7cf")) {
        self.weatherService = weatherService
    }
    
    func fetchWeather(for city: String = "Nairobi") {
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather(for: city)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] weatherResponse in
                self?.weather = weatherResponse
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func getWeather(for city: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let weatherResponse = try await weatherService.getWeather(for: city)
            self.weather = weatherResponse
        } catch {
            if let netError = error as? NetworkError {
                self.errorMessage = netError.localizedDescription
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
        isLoading = false
    }
}
