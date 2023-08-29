//
//  AddAccount.swift
//  Domain
//
//  Created by Bianca on 29/08/23.
//

import Foundation

protocol AddAccount {
    func add(addAccountModel: addAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

struct addAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}
