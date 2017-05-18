//
//  CurrentForecastTableViewCell.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class CurrentForecastTableViewCell: UITableViewCell {

    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var currentTemperatureLabel: UILabel!
    @IBOutlet private weak var pressureTextLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityTextLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var chanceOfRainTextLabel: UILabel!
    @IBOutlet private weak var chanceOfRainLabel: UILabel!
    @IBOutlet private weak var windTextLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var todayLabel: UILabel!
    @IBOutlet private weak var weekdayLabel: UILabel!
    
    var forecast: CurrentForecast? {
        didSet {
            todayLabel?.isHidden = nil == forecast
            pressureTextLabel?.isHidden = nil == forecast
            pressureLabel?.text = forecast?.pressure?.hpa
            humidityTextLabel?.isHidden = nil == forecast
            humidityLabel?.text = forecast?.humidity?.percent
            chanceOfRainTextLabel?.isHidden = nil == forecast
            chanceOfRainLabel?.text = forecast?.precipProbability?.percent
            windTextLabel?.isHidden = nil == forecast
            windLabel?.text = (forecast?.windBearing?.direction ?? "") + (forecast?.windSpeed?.kmh ?? "")
            summaryLabel?.text = forecast?.summary
            currentTemperatureLabel?.text = forecast?.temperature?.celsius
            weekdayLabel?.text = forecast?.time?.weekDay
        }
    }
}
