//
//  SignUpComposer.swift
//  MainLayer
//
//  Created by Bianca on 23/11/23.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(addAccount: addAccount)
    }
}
