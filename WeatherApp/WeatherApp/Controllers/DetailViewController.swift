//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class DetailViewController: UIViewController {
    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    public var weatherData: DailyDatum?
    public var locationName: String?
    private var cityPicURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        loadLocationPhotoURL()
        loadWeatherDetails()
    }
    
    private func loadLocationPhotoURL() {
        PixaBayAPI.getPhotos(searchQuery: locationName ?? "https://pixabay.com/get/52e4d2444a53b108f5d08460962933771738dbe75a4c704c7d2e7bd0914bcd50_1280.jpg") { (results) in
            switch results {
            case .failure(let appError):
                print("failed to load photo: \(appError)")
            case .success(let image):
                let cityPic = image.hits.randomElement()
                self.cityPicURL = cityPic?.largeImageURL
                self.loadPhoto()
            }
        }
    }
    private func loadPhoto() {
        DispatchQueue.main.async {
            self.detailView.cityImage.getImage(with: self.cityPicURL ?? "") { [ weak self ] (results) in
                switch results {
                case .failure(let appError):
                    print("failed to load detail: \(appError)")
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.detailView.cityImage.image = image
                    }
                }
            }
        }
    }
    private func loadWeatherDetails() {
        let date = NSDate(timeIntervalSince1970: TimeInterval(weatherData!.time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date as Date)
        detailView.dateLabel.text = formattedDate
        
        detailView.tempLowLabel.text = ("Low: \(weatherData?.temperatureLow.description ?? "N/A")")
        detailView.tempHighLabel.text = ("High: \(weatherData?.temperatureHigh.description ?? "N/A")")
        detailView.humidityLabel.text = ("Humidity: \(weatherData?.humidity.description ?? "N/A")")
    }
    
}
