//
//  DailyForecastTableViewCell.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var dailyForecast: [DailyForecast]? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension DailyForecastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCollectionViewCell",
                                                      for: indexPath) as! DailyForecastCollectionViewCell
        cell.dailyForecast = dailyForecast?[indexPath.row]
        return cell
    }
    
    // MARK: - Collection view delegate flow layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 40)
    }
}
