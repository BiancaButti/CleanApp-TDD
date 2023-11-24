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

    func test_signUp_shoul_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_shoul_show_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Algo inesperado aconteceu. Tente novamente em alguns instantes"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_shoul_loading_before_and_after_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    
    func test_signUp_shoul_show_success_message_if_addAccount_succeeds() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_signUp_shoul_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação",
                                                     message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(), addAccount: AddAccountSpy = AddAccountSpy(),
                 loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy, addAccount: addAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
}
