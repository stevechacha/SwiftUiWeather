//
//  WeatherErrorView.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 16/10/2024.
//

import SwiftUI

struct WeatherErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Error")
                .font(.title)
                .foregroundColor(.red)
            Text(errorMessage)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                retryAction()
            }) {
                Text("Retry")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
        }
    }
}
