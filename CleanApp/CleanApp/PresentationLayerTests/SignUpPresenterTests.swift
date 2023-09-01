//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Bianca on 31/08/23.
//

import XCTest
import Domain
import PresentationLayer

class SignUpPresenterTests: XCTestCase {
    
    func test_signUp_shoul_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Nome"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUp(name: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_shoul_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUp(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_shoul_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Password"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUp(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_shoul_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Password Confirmation"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUp(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_shoul_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUp(passwordConfirmation: "Password Confirmation"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_shoul_show_error_message_if_invalid_email_is_provider() {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUp())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_shoul_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy)
        sut.signUp(viewModel: makeSignUp())
        XCTAssertEqual(emailValidatorSpy.email, "bianca@mail.com")
    }
    
    func test_signUp_shoul_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUp())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_shoul_show_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(fieldName: "Algo inesperado aconteceu. Tente novamente em alguns instantes"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUp())
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(), emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 addAccount: AddAccountSpy = AddAccountSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy, addAccount: addAccount)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
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
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        var emit: ((AlertViewModel) -> Void)?
        
        func observe(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
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
    
    class AddAccountSpy: AddAccount {
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
    }
}
