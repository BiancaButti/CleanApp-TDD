//
//  TestFactories.swift
//  PresentationLayerTests
//
//  Created by Bianca on 08/09/23.
//

import Foundation
import PresentationLayer

func makeSignUpViewModel(name: String? = "Bianca",
                         email: String? = "bianca@mail.com",
                         password: String? = "123456",
                         passwordConfirmation: String? = "123456") -> SignUpViewModel {
    return SignUpViewModel(name: name,
                           email: email,
                           password: password,
                           passwordConfirmation: passwordConfirmation)
}
