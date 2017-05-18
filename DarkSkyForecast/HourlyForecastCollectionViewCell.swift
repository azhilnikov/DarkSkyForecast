//
//  HourlyForecastCollectionViewCell.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weekdayLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    var hourlyForecast: HourlyForecast? {
        didSet {
            timeLabel?.text = hourlyForecast?.time?.shortTime
            weekdayLabel?.text = hourlyForecast?.time?.shortWeekDay
            summaryLabel?.text = hourlyForecast?.summary
            temperatureLabel?.text = hourlyForecast?.temperature?.celsius
        }
    }
}
