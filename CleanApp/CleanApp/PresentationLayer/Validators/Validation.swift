//
//  Validation.swift
//  PresentationLayerTests
//
//  Created by Bianca on 24/11/23.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
