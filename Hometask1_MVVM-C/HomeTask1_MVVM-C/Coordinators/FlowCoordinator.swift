//
//  LoginCoordinator.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import UIKit

protocol FlowCoordinatorDelegate: class {
    func successfullyLoggedIn()
    func logout()
}

class FlowCoordinator: Coordinator {
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        if Defaults.isLoggedIn {
            presenter.pushViewController(getListOfStringsViewController(), animated: true)
        } else {
            presenter.pushViewController(getLoginViewController(), animated: true)
        }
    }
    
    private func getListOfStringsViewController() -> ListOfStringsViewController {
        let listOfStringsViewController = ListOfStringsViewController(nibName: nil, bundle: nil)
        listOfStringsViewController.title = "List of strings"
        let model = ListOfStringsViewModel(view: listOfStringsViewController, flowCoordinatorDelegate: self)
        listOfStringsViewController.model = model
        return listOfStringsViewController
    }
    
    private func getLoginViewController() -> LoginViewController {
        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
        loginViewController.title = "Login"
        let model = LoginViewModel(view: loginViewController, flowCoordinatorDelegate: self)
        loginViewController.model = model
        return loginViewController
    }
}

extension FlowCoordinator: FlowCoordinatorDelegate {
    func successfullyLoggedIn() {
        Defaults.isLoggedIn = true
        presenter.setViewControllers([getListOfStringsViewController()], animated: true)
    }
    
    func logout() {
        Defaults.isLoggedIn = false
        presenter.setViewControllers([getLoginViewController()], animated: true)
    }
}

