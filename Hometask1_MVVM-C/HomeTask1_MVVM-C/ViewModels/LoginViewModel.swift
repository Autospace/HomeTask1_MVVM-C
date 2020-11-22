//
//  LoginViewModel.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import Foundation

protocol LoginViewModelDelegate: class {
    func signIn(username: String, password: String)
}

class LoginViewModel {
    weak var view: LoginViewInterface?
    weak var flowCoordinatorDelegate: FlowCoordinatorDelegate?
    
    init(view: LoginViewInterface, flowCoordinatorDelegate: FlowCoordinatorDelegate) {
        self.view = view
        self.flowCoordinatorDelegate = flowCoordinatorDelegate
    }
}

extension LoginViewModel: LoginViewModelDelegate {
    func signIn(username: String, password: String) {
        if username == "user", password == "123qwe" {
            flowCoordinatorDelegate?.successfullyLoggedIn()
        } else {
            view?.showError(with: "Invalid username or password")
        }
    }
}
