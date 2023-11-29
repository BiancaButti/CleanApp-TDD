//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Bianca on 29/11/23.
//

import Foundation
import PresentationLayer

public final class ValidationSpy: Validation {
    var errorMessage: String?
    var data: [String: Any]?
    
    public func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    public func simulateError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
