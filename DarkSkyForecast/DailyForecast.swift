//
//  DailyForecast.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import Gloss

struct DailyForecast: Decodable {
    
    let temperatureMax: Double?
    let temperatureMin: Double?
    let summary: String?
    let time: TimeInterval?
    
    // MARK: - Decodable
    
    init?(json: JSON) {
        temperatureMax = "temperatureMax" <~~ json
        temperatureMin = "temperatureMin" <~~ json
        summary = "summary" <~~ json
        time = "time" <~~ json
    }
}
