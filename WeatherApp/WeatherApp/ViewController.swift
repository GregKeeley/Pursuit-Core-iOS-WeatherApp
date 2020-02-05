//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var localWeatherData: [DarkSkyWeatherData]? {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collection.reloadData()
            }
        }
    }
    
    
    private var lat = Double()
    private var long = Double()
    private var locationName = String()
    
    private let mainView = MainView()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        mainView.collection.delegate = self
        mainView.collection.dataSource = self
        mainView.textField.delegate = self
        mainView.collection.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "weatherCell")
        
    }
    private func getLatLong(_ textField: String) {
        ZipCodeHelper.getLatLong(fromZipCode: textField) { (results) in
            switch results {
            case .failure(let fetchingError):
                print("Unable to load location data: \(fetchingError)")
            case .success(let locationData):
                self.lat = locationData.lat
                self.long = locationData.long
                self.locationName = locationData.placeName
            }
        }
    }
    private func loadWeatherData() {
       DarkSkyAPI.getWeatherData(lat: self.lat, long: self.long) { (results) in
           switch results {
           case .failure(let appError):
               print("Unable to load weather data: \(appError)")
           case .success(let weatherData):
            self.localWeatherData = [weatherData]
            dump(weatherData)
           }
       }
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getLatLong(textField.text ?? "11377")
        textField.resignFirstResponder()
        loadWeatherData()
        return true
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.collection.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCell else {
            fatalError("Failed to dequeue collection view cell")
            
        }
        guard !localWeatherData!.isEmpty else { return cell }
        cell.configureCell(localWeatherData!, indexPath: indexPath)
        return cell
    }
    
    
}
