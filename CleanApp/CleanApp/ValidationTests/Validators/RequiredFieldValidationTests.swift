//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Bianca on 24/11/23.
//
import XCTest
import PresentationLayer
import Validation

class RequiredFieldValidationTests: XCTestCase {
    
    func test_validate_shoul_return_error_if_field_is_not_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["name": "Bianca"])
        XCTAssertEqual(errorMessage, "O campo Email é obrigatório")
    }
    
    func test_validate_shoul_return_error_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "age", fieldLabel: "Idade")
        let errorMessage = sut.validate(data: ["name": "Bianca"])
        XCTAssertEqual(errorMessage, "O campo Idade é obrigatório")
    }
    
    func test_validate_shoul_return_nil_with_field_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "bianca@gmail.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_shoul_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é obrigatório")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
