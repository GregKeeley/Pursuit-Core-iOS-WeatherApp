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
    static func darkSkyAPI(for lat: String, long: String, completion: @escaping (Result<[DarkSkyWeatherData],AppError>) -> ()) {
        let latLong = "\(lat),\(long)"
        let darkSkyEndpoint = "https://api.darksky.net/forecast/\(SecretKey.darkSkyKey)/\(latLong)"
        guard let url = URL(string: darkSkyEndpoint) else {
            completion(.failure(.badURL(darkSkyEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (results) in
            switch results {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let weatherData):
                do {
                    let results = try JSONDecoder().decode([DarkSkyWeatherData].self, from: weatherData)
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
}
