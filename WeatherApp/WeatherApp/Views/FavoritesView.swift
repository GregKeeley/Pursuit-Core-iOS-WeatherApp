//
//  FavoritesView.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/8/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    public lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        constraintsTableView()
    }
    private func constraintsTableView() {
        addSubview(favoritesTableView)
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            favoritesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
}
