//
//  MainDispatchQueueDecorator.swift
//  MainLayer
//
//  Created by Bianca on 24/11/23.
//

import Foundation
import Domain

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
