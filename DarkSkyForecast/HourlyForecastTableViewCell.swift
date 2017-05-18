//
//  HourlyForecastTableViewCell.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var hourlyForecast: [HourlyForecast]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension HourlyForecastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell",
                                                      for: indexPath) as! HourlyForecastCollectionViewCell
        if let forecast = hourlyForecast?[indexPath.row] {
            cell.hourlyForecast = forecast
        }
        return cell
    }
    
    // MARK: - Collection view delegate flow layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 106)
    }
}
