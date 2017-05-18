//
//  DarkSkyDataStructure.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum DarkSkyAPIResult {
    case success
    case failure(Error)
}

enum DarkSkyAPIError: Error {
    case noInternetConnection
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case invalidData
    case invalidJSONFormat
}

extension DarkSkyAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No Internet connection", comment: "")
            
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
            
        case .invalidResponse:
            return NSLocalizedString("Invalid Response", comment: "")
            
        case .invalidStatusCode:
            return NSLocalizedString("Invalid status code", comment: "")
            
        case .invalidData:
            return NSLocalizedString("Invalid data", comment: "")
            
        case .invalidJSONFormat:
            return NSLocalizedString("Invalid JSON format", comment: "")
        }
    }
}

extension Double {
    var celsius: String {
        return String(Int(self)) + "ºC"
    }
    
    var hpa: String {
        return String(Int(self)) + " hPa"
    }
    
    var percent: String {
        return String(Int(self * 100)) + "%"
    }
    
    var kmh: String {
        return String(Int(self)) + " km/h"
    }
    
    var direction: String {
        switch self {
        case 45..<135:
            return "W "
        case 135..<225:
            return "N "
        case 225..<315:
            return "E "
        default:
            return "S "
        }
    }
}

extension TimeInterval {
    var shortTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
    
    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
    
    var shortWeekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
