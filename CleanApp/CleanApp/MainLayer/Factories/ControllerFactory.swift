//
//  ControllerFactory.swift
//  MainLayer
//
//  Created by Bianca on 23/11/23.
//

import Foundation
import UI
import PresentationLayer
import Validation
import DataLayer
import Infra
import Domain

class ControllerFactory {
    
    static func makeSignUp(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
                                                
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller),
                                        emailValidator: emailValidatorAdapter,
                                        addAccount: addAccount,
                                        loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        return controller
    }
}
