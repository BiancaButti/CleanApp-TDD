//
//  Model.swift
//  Domain
//
//  Created by Bianca on 29/08/23.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
