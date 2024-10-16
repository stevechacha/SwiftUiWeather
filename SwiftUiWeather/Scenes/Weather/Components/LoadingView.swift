//
//  LoadingView.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 16/10/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Spacer()
        ProgressView("Fetching Weather...")
        Spacer()
    }
}
