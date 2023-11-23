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
    static func makeRemoteAddAccount() -> AddAccount {
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        return RemoteAddAccount(url: url,
                                httpClient: alamofireAdapter)
        
    }
}
