//
//  DetailView.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var cityImage: UIImageView = {
        let image = UIImageView()
        return image
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
        constraintsCityImage()
    }
    
    private func constraintsCityImage() {
        addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            cityImage.topAnchor.constraint(equalTo: topAnchor),
            cityImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cityImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cityImage.heightAnchor.constraint(equalTo: cityImage.widthAnchor)
        
        ])
    }
}
