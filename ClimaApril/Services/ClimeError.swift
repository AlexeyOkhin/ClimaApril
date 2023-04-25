//
//  ClimeError.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 25.04.2023.
//

import Foundation

enum ClimeError: Error {
    case makeRequest
    case noData
    case redirect
    case badRequest
    case serverError
    case unexpectedStatus
}
