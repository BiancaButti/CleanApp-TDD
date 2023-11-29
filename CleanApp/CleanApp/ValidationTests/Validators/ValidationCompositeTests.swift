//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Bianca on 28/11/23.
//

import XCTest
import PresentationLayer
import Validation

final class ValidationCompositeTests: XCTestCase {

    func test_validate_shoul_return_error_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: [validationSpy])
        validationSpy.simulateError("Erro 1")
        let errorMessage = sut.validate(data: ["name": "Bianca"])
        XCTAssertEqual(errorMessage, "Erro 1")
    }
    
    func test_validate_shoul_return_correct_error_message() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: [validationSpy])
        validationSpy.simulateError("Erro 2")
        let errorMessage = sut.validate(data: ["name": "Bianca"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_shoul_return_the_first_error_message() {
        let validationSpy = ValidationSpy()
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        
        let sut = makeSut(validation: [validationSpy, validationSpy2, validationSpy3])
        validationSpy2.simulateError("Erro 2")
        validationSpy3.simulateError("Erro 3")

        let errorMessage = sut.validate(data: ["name": "Bianca"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_shoul_return_nil_if_validation_succeeds() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: [validationSpy])
        let errorMessage = sut.validate(data: ["name": "Bianca"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_shoul_call_validation_with_correct_data() {
        let validationSpy = ValidationSpy()

        let sut = makeSut(validation: [validationSpy])
        let data = ["name": "Bianca"]
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(validation: [ValidationSpy], file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = ValidationComposite(validations: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
