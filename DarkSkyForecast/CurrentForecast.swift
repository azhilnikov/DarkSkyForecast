//
//  CurrentForecast.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import Gloss

struct CurrentForecast: Decodable {
    
    let summary: String?
    let temperature: Double?
    let time: TimeInterval?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windBearing: Double?
    let precipProbability: Double?
    
    // MARK: - Decodable
    
    init?(json: JSON) {
        summary = "summary" <~~ json
        temperature = "temperature" <~~ json
        time = "time" <~~ json
        humidity = "humidity" <~~ json
        pressure = "pressure" <~~ json
        windSpeed = "windSpeed" <~~ json
        windBearing = "windBearing" <~~ json
        precipProbability = "precipProbability" <~~ json
    }
}
