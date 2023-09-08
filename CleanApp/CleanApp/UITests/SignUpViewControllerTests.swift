//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Bianca on 08/09/23.
//

import XCTest
import UIKit
import PresentationLayer
@testable import UI

final class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
}

extension SignUpViewControllerTests {
    func makeSut() -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        return sut
    }
}
