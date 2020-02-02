//
//  darkSkty.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct DarkSkyAPI {
    static func darkSkyAPI(for lat: String, long: String, completion: @escaping (Result<Data,AppError>) -> ()) {
       let latLong = "\(lat),\(long)"
        let darkSkyEndpoint = "https://api.darksky.net/forecast/\(SecretKey.darkSkyKey)/\(latLong)"
    }
    
}
