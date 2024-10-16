//
//  WeatherView.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 15/10/2024.
//

import SwiftUI
import Combine

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = "Mabera" // Default city
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Group {
                    if viewModel.isLoading {
                        LoadingView()
                    } else if let errorMessage = viewModel.errorMessage {
                        WeatherErrorView(errorMessage: errorMessage, retryAction: {
                            Task {
                                await viewModel.getWeather(for: city)
                            }
                        })
                    } else if let weather = viewModel.weather {
                        WeatherContentView(weather: weather)
                    } else {
                        Spacer()
                        Text("Enter a city to get weather information.")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                }
                .padding()
            }
            .navigationTitle("Weather App")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search City")
            .onSubmit(of: .search) {
                performSearch()
            }
            .onAppear {
                Task {
                    await viewModel.getWeather(for: city)
                }
            }
        }
    }
    
    private func performSearch() {
        let trimmedCity = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedCity.isEmpty else { return }
        city = trimmedCity
        Task {
            await viewModel.getWeather(for: city)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

