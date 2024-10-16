//
//  FrameworkGridViewModel.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 21/09/2024.
//

import Foundation

final class FrameworkGridViewModel : ObservableObject {
    var selectedFramework : Framework? {
        didSet {
            isShowingDetailView = true
        }
    } 
    
    @Published var isShowingDetailView = false
    
}
