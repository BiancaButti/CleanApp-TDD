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
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        sut.signUp(viewModel: makeSignUp(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Nome é obrigatório"))
    }

    func test_signUp_shoul_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        sut.signUp(viewModel: makeSignUp(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Email é obrigatório"))
    }
    
    func test_signUp_shoul_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        sut.signUp(viewModel: makeSignUp(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Password é obrigatório"))
    }
    
    func test_signUp_shoul_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        sut.signUp(viewModel: makeSignUp(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "O campo Password Confirmation é obrigatório"))
    }
    
    func test_signUp_shoul_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        sut.signUp(viewModel: makeSignUp(password: "asdad",
                                         passwordConfirmation: "fgsdgfsdf"))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "Falha ao confirmar senha"))
    }
    
    func test_signUp_shoul_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy)
        sut.signUp(viewModel: makeSignUp())
        XCTAssertEqual(emailValidatorSpy.email, "any_email@mi.com")
    }
    
    func test_signUp_shoul_show_error_message_if_invalid_email_is_provider() {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUp())
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação",
                                                              message: "Email inválido"))
    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(), emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        return sut
    }
    
    func makeSignUp(name: String? = "teste", email: String? = "any_email@mi.com",
                    password: String? = "123", passwordConfirmation: String? = "123") -> SignUpViewModel {
        return SignUpViewModel(name: name,
                               email: email,
                               password: password,
                               passwordConfirmation: passwordConfirmation)
    }
    
    class AlertViewSpy: AlertView {
        
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func simulateInvalidEmail() {
            isValid = false
        }
    }
}
