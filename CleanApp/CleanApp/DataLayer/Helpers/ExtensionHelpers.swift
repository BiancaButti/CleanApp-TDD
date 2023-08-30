//
//  ExtensionHelpers.swift
//  DataLayer
//
//  Created by Bianca on 30/08/23.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
