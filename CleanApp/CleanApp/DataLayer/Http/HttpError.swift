//
//  HttpError.swift
//  DataLayer
//
//  Created by Bianca on 30/08/23.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case unanthorized
    case forbidden
    case serverError
}
