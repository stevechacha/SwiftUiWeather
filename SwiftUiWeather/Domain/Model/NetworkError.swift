//
//  NetworkError.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 16/10/2024.
//


import Foundation

// Define Network Errors
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case decodingError
    case unableToComplete

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .invalidResponse(let statusCode):
            return "Received invalid response from server with status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response."
        case .unableToComplete:
            return "Unable to complete the request. Please check your internet connection."
        }
    }
}
