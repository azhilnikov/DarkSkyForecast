//
//  DailyData.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import Gloss

struct DailyData: Decodable {
    
    let data: [DailyForecast]?
    
    // MARK: - Decodable
    
    init?(json: JSON) {
        data = "data" <~~ json
    }
}
