//
//  SingUpFactory.swift
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

class SingUpFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        
        let remoteAddAccount = RemoteAddAccount(url: url,
                                                httpClient: alamofireAdapter)
        let presenter = SignUpPresenter(alertView: controller,
                                        emailValidator: emailValidatorAdapter,
                                        addAccount: remoteAddAccount,
                                        loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
