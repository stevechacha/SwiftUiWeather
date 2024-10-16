//
//  WeatherSearchBar.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 16/10/2024.
//

import SwiftUI

struct WeatherSearchBar: View {
    @Binding var city: String
    let fetchWeather: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter city name", text: $city, onCommit: {
                fetchWeather()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .padding(.horizontal)
            
            Button(action: {
                fetchWeather()
            }) {
                Image(systemName: "magnifyingglass")
                    .padding()
            }
        }
    }
}
