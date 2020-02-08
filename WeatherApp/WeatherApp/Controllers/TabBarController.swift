//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/8/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {

    private var dataPersistence = DataPersistence<ImageObject>(filename: "favoriteImage.plist")
    
    private lazy var forecastVC: ViewController = {
        let viewController = ViewController()
        viewController.dataPersistence = dataPersistence
        viewController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud"), tag: 0)
        return viewController
    }()
    private lazy var favoritesVC: FavoritesViewController = {
        let viewController = FavoritesViewController()
        viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    private lazy var detailVC: DetailViewController = {
        let viewController = DetailViewController()
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: forecastVC), UINavigationController(rootViewController: favoritesVC)]
    }
    



}
