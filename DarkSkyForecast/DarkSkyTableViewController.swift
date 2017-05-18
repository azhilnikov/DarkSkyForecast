//
//  DarkSkyTableViewController.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

private let darkSkyCellInfo: [(identifier: String, height: CGFloat)] = [
    (identifier: "CurrentForecastCell", height: 250),
    (identifier: "HourlyForecastCell", height: 110),
    (identifier: "DailyForecastCell", height: 315)
]

class DarkSkyTableViewController: UITableViewController {

    fileprivate let darkSkyService = DarkSkyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkSkyService.fetch(completion: { [weak self] result in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success:
                    self?.tableView.reloadData()
                    
                case .failure(let error as DarkSkyAPIError):
                    self?.showAlert(title: "Error", message: error.errorDescription)
                    
                default:
                    self?.showAlert(title: "Error", message: "Unknown error")
                }
            })
        })
    }

    // MARK: - Private method
    
    fileprivate func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension DarkSkyTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return darkSkyCellInfo.count
    }
    
    // MARK: - Table view data delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: darkSkyCellInfo[indexPath.row].identifier,
                                                 for: indexPath)
        
        if let currentForecastCell = cell as? CurrentForecastTableViewCell {
            currentForecastCell.forecast = darkSkyService.forecast?.currentForecast
        }
        if let hourlyForecastCell = cell as? HourlyForecastTableViewCell {
            hourlyForecastCell.hourlyForecast = darkSkyService.forecast?.hourly?.data
        }
        if let dailyForecastCell = cell as? DailyForecastTableViewCell {
            dailyForecastCell.dailyForecast = darkSkyService.forecast?.daily?.data
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return darkSkyCellInfo[indexPath.row].height
    }
}
