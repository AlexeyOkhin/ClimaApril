//
//  ImageLoader.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import UIKit
import SVGKit

struct ImageLoader {

    let session = URLSession(configuration: .default)

    func loadImage(from stringUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let url = URL(string: stringUrl) {
            session.dataTask(with: url) { data, _, error in

                if let error = error {
                    completion(.failure(error))
                }
                if let data = data, let image = SVGKImage(data: data).uiImage {
                    completion(.success(image))
                }
            }.resume()
        }
    }
}
