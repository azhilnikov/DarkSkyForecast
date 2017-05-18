//
//  Forecast.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import Gloss

struct Forecast {
    
    let currentForecast: CurrentForecast?
    let daily: DailyData?
    let hourly: HourlyData?
    
    // MARK: - Decodable
    
    init?(json: JSON) {
        currentForecast = "currently" <~~ json
        daily = "daily" <~~ json
        hourly = "hourly" <~~ json
    }
}
