//
//  PixaBayAPI.swift
//  WeatherApp
//
//  Created by Gregory Keeley on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import NetworkHelper

struct PixaBayAPI {
    static func getPhotos(searchQuery: String, completion: @escaping (Result<PixaBayImage, AppError>) -> ()) {
        let pixaBayEndpoint = "https://pixabay.com/api/?key=\(SecretKey.pixaBayKey)&q=\(searchQuery.lowercased())"
        print(pixaBayEndpoint)
        guard let url = URL(string: pixaBayEndpoint) else {
            completion(.failure(.badURL(pixaBayEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (results) in
            switch results {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(PixaBayImage.self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
