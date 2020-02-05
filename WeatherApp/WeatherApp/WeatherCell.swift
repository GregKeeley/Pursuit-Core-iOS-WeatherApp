//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    @IBOutlet weak var weatherImage: UIImageView!
    func configureCell(_ weatherData: DarkSkyWeatherData) {
        weatherImage.image = UIImage(named: "\(weatherData.daily.icon)")
    }
}
