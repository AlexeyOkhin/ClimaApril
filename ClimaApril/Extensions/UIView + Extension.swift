//
//  UIView + Extension.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView..., priority: Float? = nil, constraints: () -> ([NSLayoutConstraint])) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        let constraints = constraints()
        if let priority {
            constraints.forEach { $0.priority = .init(priority) }
        }
        NSLayoutConstraint.activate(constraints)
    }
}
