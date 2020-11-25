//
//  VewModelsTests.swift
//  HomeTask1_MVVM-CTests
//
//  Created by Aliaksei Mastounikau on 11/25/20.
//

import XCTest
@testable import HomeTask1_MVVM_C

internal class LoginViewInterfaceMock: LoginViewInterface {
    var handlerOfShowError: (() -> Void)?
    func showError(with message: String) {
        handlerOfShowError?()
    }
}

internal class LoginViewModelDelegateMock: LoginViewModelDelegate {
    func signIn(username: String, password: String) {

    }
}

internal class FlowCoordinatorDelegateMock: FlowCoordinatorDelegate {
    var handlerOfSuccessfulLogin: (() -> Void)?
    var handlerOfLogout: (() -> Void)?

    func successfullyLoggedIn() {
        handlerOfSuccessfulLogin?()
    }

    func logout() {
        handlerOfLogout?()
    }
}

class VewModelsTests: XCTestCase {
    var loginViewInterfaceMock: LoginViewInterfaceMock!
    var loginViewModelDelegateMock: LoginViewModelDelegateMock!
    var flowCoordinatorDelegateMock: FlowCoordinatorDelegateMock!
    var didShowError = false

    override func setUp() {
        loginViewInterfaceMock = LoginViewInterfaceMock()
        loginViewModelDelegateMock = LoginViewModelDelegateMock()
        flowCoordinatorDelegateMock = FlowCoordinatorDelegateMock()
    }

    
    func testLoginViewModel() {
        let viewModel = LoginViewModel(view: loginViewInterfaceMock, flowCoordinatorDelegate: flowCoordinatorDelegateMock)
        var didSucessfulLogin = false
        var didShowError = false
        flowCoordinatorDelegateMock.handlerOfSuccessfulLogin = { () in
            didSucessfulLogin = true
        }
        loginViewInterfaceMock.handlerOfShowError = { () in
            didShowError = true
        }
        viewModel.signIn(username: "user", password: "wrong")
        XCTAssertTrue(didShowError)
        XCTAssertFalse(didSucessfulLogin)
        viewModel.signIn(username: "user", password: "123qwe")
        XCTAssertTrue(didSucessfulLogin)
    }
}
