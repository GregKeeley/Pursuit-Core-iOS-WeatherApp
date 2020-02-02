//
//  MainView.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    public lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        
        let cv = UICollectionView(frame: CGRect.zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemGray
        cv.layer.cornerRadius = 8
        return cv
    }()
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        return textField
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
        setupCollectionViewConstraints()
        setupTextFieldConstraints()
    }
    private func setupCollectionViewConstraints() {
        addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            collection.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            collection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collection.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor)
            
        ])
    }
    private func setupTextFieldConstraints() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            textField.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 80),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            textField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
                    
        ])
    }
}
