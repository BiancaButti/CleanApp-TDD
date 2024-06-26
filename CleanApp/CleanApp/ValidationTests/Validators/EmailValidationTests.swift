//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Bianca on 28/11/23.
//

import XCTest
import PresentationLayer
import Validation

final class EmailValidationTests: XCTestCase {

    func test_validate_shoul_return_error_if_invalid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "teste@gmail.com"])
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }
    
    func test_validate_shoul_return_error_if_correct_field_label() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "teste@gmail.com"])
        XCTAssertEqual(errorMessage, "O campo Email2 é inválido")
    }
    
    func test_validate_shoul_return_nil_if_valid_email_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: EmailValidatorSpy())
        let errorMessage = sut.validate(data: ["email": "teste@gmail.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_shoul_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy())
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }
}

extension EmailValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorSpy,
                 file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = EmailValidation(fieldName: fieldName,
                                  fieldLabel: fieldLabel,
                                  emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
