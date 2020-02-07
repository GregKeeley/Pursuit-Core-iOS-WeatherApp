//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderLabel: UILabel!
}

class ViewController: UIViewController {
    
    private var localWeatherData: Daily? {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    
    private var lat = Double()
    private var long = Double()
    private var locationName = String() {
        didSet {
            
        }
    }
    
    private let mainView = MainView()
   
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.textField.delegate = self
        mainView.collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "weatherCell")
        mainView.collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "sectionLabel")
        getLatLong("11377")
        loadWeatherData()
    }
    override func viewWillAppear(_ animated: Bool) {
                navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(false, animated: animated)
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
                print(self.lat, self.long)
            }
        }
    }
    private func loadWeatherData() {
       DarkSkyAPI.getWeatherData(lat: self.lat, long: self.long) { (results) in
           switch results {
           case .failure(let appError):
               print("Unable to load weather data: \(appError)")
           case .success(let weatherData):
            self.localWeatherData = weatherData
           }
       }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionLabel", for: indexPath) as? SectionHeader {
            sectionHeader.sectionHeaderLabel.text = "\(locationName)"
            print(locationName)
            return sectionHeader
        }
        return UICollectionReusableView()
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
        return CGSize(width: 300, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.weatherData = localWeatherData?.data[indexPath.row]
        detailVC.locationName = self.locationName
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}



extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localWeatherData?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCell else {
            fatalError("Failed to dequeue collection view cell")
        }
        cell.layer.cornerRadius = 8
        cell.configureCell((localWeatherData?.data[indexPath.row])!)
        return cell
    }
    
    
}
