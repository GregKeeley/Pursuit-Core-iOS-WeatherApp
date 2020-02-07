//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    public var weatherData: DailyDatum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
       dump(weatherData)
    }
    



}
