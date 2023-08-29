//
//  RemoteAddAccount.swift
//  DataLayer
//
//  Created by Bianca on 29/08/23.
//

import Foundation
import Domain

public final class RemoteAddAccount {
    
    public let url: URL
    public let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient    }
    
    public func add(addAccountModel: AddAccountModel) {
        httpClient.post(to: url, with: addAccountModel.toData())
    }
}
