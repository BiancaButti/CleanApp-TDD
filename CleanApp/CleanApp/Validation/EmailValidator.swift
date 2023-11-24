//
//  EmailValidator.swift
//  PresentationLayer
//
//  Created by Bianca on 31/08/23.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool 
}
