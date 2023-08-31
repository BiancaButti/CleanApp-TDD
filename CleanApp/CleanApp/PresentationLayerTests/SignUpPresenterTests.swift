//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Bianca on 31/08/23.
//

import XCTest
import PresentationLayer

class SignUpPresenterTests: XCTestCase {
    
    func test_signUp_shoul_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "any_email@mi.com",
                                              password: "123",
                                              passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Nome é obrigatório"))
    }

    func test_signUp_shoul_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "fulano",
                                              password: "123",
                                              passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Email é obrigatório"))
    }
    
    func test_signUp_shoul_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "fulano",
                                              email: "123",
                                              passwordConfirmation: "adfasdfas")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Password é obrigatório"))
    }
    
    func test_signUp_shoul_show_error_message_if_password_confirmation_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "fulano",
                                              email: "123",
                                              password: "asdad")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Password Confirmation é obrigatório"))
    }
    
    func test_signUp_shoul_show_error_message_if_password_confirmation_not_match() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "fulano",
                                              email: "123",
                                              password: "asdad",
                                              passwordConfirmation: "fgsdgfsdf")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "Falha ao confirmar senha"))
    }
}

extension SignUpPresenterTests {
    
    func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    
    class AlertViewSpy: AlertView {
        
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
