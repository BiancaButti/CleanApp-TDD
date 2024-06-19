//
//  UseCaseFactory.swift
//  MainLayer
//
//  Created by Bianca on 23/11/23.
//

import Foundation
import DataLayer
import Infra
import Domain

final class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Environment.variable(.apiBaseUrl)
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    static func makeRemoteAddAccount() -> AddAccount {
        
        return RemoteAddAccount(url: makeUrl(path: "signup"),
                                httpClient: httpClient)
        
    }
}
