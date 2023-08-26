//
//  Logger.swift
//  RickSndMorty
//
//  Created by Yury on 26/08/2023.
//

import Foundation

struct Logger {
    
    // MARK: - Properties
    static var isLoggingEnabled = false // Flag to enable/disable logging
    
}

// MARK: - Methods
extension Logger {
    
    
    // Method for logging response information
    static func logResponse(_ response: URLResponse) {
        guard isLoggingEnabled else { return }
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            log("HTTP Status Code: \(statusCode)")
        } else {
            log("URL Response: \(response)")
        }
    }
    
    // Method for logging URLSession error with description
    static func logErrorDescription(_ error: Error) {
        guard isLoggingEnabled else { return }
        
        print(error.localizedDescription)
    }
    
    // General method for logging
    static func log(_ message: String) {
        guard isLoggingEnabled else { return }
        
        print(message)
    }
}

