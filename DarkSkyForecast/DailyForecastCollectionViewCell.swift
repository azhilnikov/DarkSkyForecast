//
//  DailyForecastCollectionViewCell.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class DailyForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var weekdayLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    
    var dailyForecast: DailyForecast? {
        didSet {
            weekdayLabel?.text = dailyForecast?.time?.weekDay
            summaryLabel?.text = dailyForecast?.summary
            maxTemperatureLabel?.text = dailyForecast?.temperatureMax?.celsius
            minTemperatureLabel?.text = dailyForecast?.temperatureMin?.celsius
        }
    }
}
