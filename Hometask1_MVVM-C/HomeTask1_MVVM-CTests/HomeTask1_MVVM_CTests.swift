//
//  HomeTask1_MVVM_CTests.swift
//  HomeTask1_MVVM-CTests
//
//  Created by Alex Mostovnikov on 20/11/20.
//

import XCTest
@testable import HomeTask1_MVVM_C

class HomeTask1_MVVM_CTests: XCTestCase {
    var loginViewInterfaceMock: LoginViewInterfaceMock!
    var loginViewModelDelegateMock: LoginViewModelDelegateMock!
    var flowCoordinatorDelegateMock: FlowCoordinatorDelegateMock!
    var listOfStringsViewInterfaceMock: ListOfStringsViewInterfaceMock!

    override func setUp() {
        loginViewInterfaceMock = LoginViewInterfaceMock()
        loginViewModelDelegateMock = LoginViewModelDelegateMock()
        flowCoordinatorDelegateMock = FlowCoordinatorDelegateMock()
        listOfStringsViewInterfaceMock = ListOfStringsViewInterfaceMock()
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
    
    func testListOfStringsViewModel() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        let networkService = NetworkService(urlSession: urlSession)
        let data = Data()
        let expectation = XCTestExpectation(description: "Load data expectation")
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw ResponseError(message: "Wrong response")
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        let viewModel = ListOfStringsViewModel(view: listOfStringsViewInterfaceMock, flowCoordinatorDelegate: flowCoordinatorDelegateMock, networkService: networkService)
        var didLogOut = false
        var didShowListOfStrings = false
        flowCoordinatorDelegateMock.handlerOfLogout = { () in
            didLogOut = true
        }
        viewModel.logout()
        XCTAssertTrue(didLogOut)
        listOfStringsViewInterfaceMock.handlerOfShowListOfStrings = { () in
            didShowListOfStrings = true
            expectation.fulfill()
        }
        viewModel.loadData()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(didShowListOfStrings)
    }
}

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

internal class ListOfStringsViewInterfaceMock: ListOfStringsViewInterface {
    var handlerOfShowListOfStrings: (() -> Void)?
    var handlerOfShowError: (() -> Void)?
    
    func showListOfStrings(strings: String) {
        handlerOfShowListOfStrings?()
    }
    
    func showError(with message: String) {
        handlerOfShowError?()
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
