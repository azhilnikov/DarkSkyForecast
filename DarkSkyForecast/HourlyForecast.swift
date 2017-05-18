//
//  HourlyForecast.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import Gloss

struct HourlyForecast: Decodable {
    
    let summary: String?
    let temperature: Double?
    let time: TimeInterval?
    
    // MARK: - Decodable
    
    init?(json: JSON) {
        summary = "summary" <~~ json
        temperature = "temperature" <~~ json
        time = "time" <~~ json
    }
}
