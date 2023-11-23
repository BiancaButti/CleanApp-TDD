//
//  SignUpIntegrationTests.swift
//  MainLayerTests
//
//  Created by Bianca on 23/11/23.
//

import XCTest
import MainLayer

class SignUpIntegrationTests: XCTestCase {

    func test_ui_presentation_integration() {
        debugPrint("=====================================")
        debugPrint(Environment.variable(.apiBaseUrl))
        debugPrint("=====================================")
        let sut = SignUpComposer.composeControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
