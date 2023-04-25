//
//  UIImageView + Extension.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import UIKit

extension UIImageView {

    func loadImage(from stringUrl: String) {
        ImageLoader().loadImage(from: stringUrl) { [weak self] result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = UIImage(systemName: "questionmark.circle")
                }
            }
        }
    }
}
