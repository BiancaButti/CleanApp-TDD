//
//  EmailValidatorAdapterTests.swift
//  EmailValidatorAdapterTests
//
//  Created by Bianca on 22/11/23.
//

import XCTest
import PresentationLayer

public final class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, range: range) != nil
    }
}

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }

    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "rbianca@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "bianca@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "rr@teste.com"))
    }
    
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
