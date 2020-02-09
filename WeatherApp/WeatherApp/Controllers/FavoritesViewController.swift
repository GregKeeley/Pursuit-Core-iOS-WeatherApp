//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/8/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence
class FavoritesViewController: UIViewController {

    private var favoriteImages = [ImageObject]() {
        didSet {
            favoriteView.favoritesTableView.reloadData()
            print(favoriteImages.count)
        }
    }
    
    private let favoriteView = FavoritesView()
    override func loadView() {
        view = favoriteView
    }
    public var dataPersistence: DataPersistence<ImageObject>!
    override func viewDidAppear(_ animated: Bool) {
        loadFavoriteImages()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        favoriteView.favoritesTableView.delegate = self
        favoriteView.favoritesTableView.dataSource = self
        favoriteView.favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favoriteImageCell")
        loadFavoriteImages()
        
    }
    
    private func loadFavoriteImages() {
        do {
            favoriteImages = try dataPersistence.loadItems()
            print(favoriteImages.count)
        } catch {
            print("Error loading Images: \(error)")
        }
    }
    
}
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteImageCell", for: indexPath)
       
        let data = favoriteImages.reversed()[indexPath.row]
        guard let image = UIImage(data: data.imageData) else {
            print("Failed to get image")
            return cell
        }
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.layer.cornerRadius = 8
        cell.imageView?.image = image
        cell.textLabel?.text = data.locationName
        return cell
    }
    
}
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
