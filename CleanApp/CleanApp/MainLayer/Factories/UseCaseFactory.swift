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

public final class MainDispatchQueueDecorator<T> {
    private let instancee: T
    
    public init(_ instancee: T) {
        self.instancee = instancee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
    
}

extension MainDispatchQueueDecorator: AddAccount where T: AddAccount {
    public func add(addAccountModel: Domain.AddAccountModel, completion: @escaping (Result<Domain.AccountModel, Domain.DomainError>) -> Void) {
        instancee.add(addAccountModel: addAccountModel) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
