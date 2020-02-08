//
//  ImageModel.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/8/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct ImageObject: Codable & Equatable {
  let imageData: Data
  let date: Date
  let identifier = UUID().uuidString
}
