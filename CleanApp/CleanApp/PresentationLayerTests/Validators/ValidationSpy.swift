//
//  ValidationSpy.swift
//  PresentationLayerTests
//
//  Created by Bianca on 24/11/23.
//

import Foundation
import PresentationLayer

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError() {
        self.errorMessage = "Erro"
    }
}
