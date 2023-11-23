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

class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: PresentationLayer.AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
    
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: PresentationLayer.LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
    
    
}
