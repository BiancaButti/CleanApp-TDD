//
//  Environment.swift
//  MainLayer
//
//  Created by Bianca on 23/11/23.
//

import Foundation

public final class Environment {
    public enum EnvironmentsVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable(_ key: EnvironmentsVariables) -> String {
        Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
