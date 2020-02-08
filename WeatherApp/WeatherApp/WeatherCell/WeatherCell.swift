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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var tempRangeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    func configureCell(_ weatherData: DailyDatum) {
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(weatherData.time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yy"
        let formattedDate = dateFormatter.string(from: date as Date)
        dateLabel.text = String(formattedDate)
        
        forecastLabel.text = weatherData.summary
        humidityLabel.text = ("humidity: \(weatherData.humidity * 100)%")
        tempRangeLabel.text = ("\(weatherData.temperatureLow) - \(weatherData.temperatureHigh)")
        
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(named: "\(weatherData.icon)")
        }
    }
    
}
