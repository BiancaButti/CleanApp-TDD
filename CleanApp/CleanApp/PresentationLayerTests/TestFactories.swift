//
//  TestFactories.swift
//  PresentationLayerTests
//
//  Created by Bianca on 08/09/23.
//

import Foundation
import PresentationLayer

func makeSignUp(name: String? = "Bianca", email: String? = "bianca@mail.com",
                password: String? = "123456", passwordConfirmation: String? = "123456") -> SignUpViewModel {
    return SignUpViewModel(name: name,
                           email: email,
                           password: password,
                           passwordConfirmation: passwordConfirmation)
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação",
                         message: "O campo \(fieldName) é obrigatório")
}

func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação",
                         message: "O campo \(fieldName) é inválido")
}

func makeErrorAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Erro",
                         message: fieldName)
}

func makeSuccessAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso",
                         message: fieldName)
}
