//
//  SignUpComposer.swift
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

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller),
                                        addAccount: addAccount,
                                        loadingView: WeakVarProxy(controller),
                                        validation: validation)
        controller.signUp = presenter.signUp
        return controller
    }
}
