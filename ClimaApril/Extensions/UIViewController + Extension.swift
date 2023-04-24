//
//  UIViewController + Extension.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import UIKit

extension UIViewController {

    func showErrorAlert(with title: String = "Ошибка!!!", and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
