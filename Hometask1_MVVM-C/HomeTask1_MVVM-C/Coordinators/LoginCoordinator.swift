//
//  LoginCoordinator.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import UIKit

class FlowCoordinator: Coordinator {
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        if Defaults.isLoggedIn {
            let listOfStringsViewController = ListOfStringsViewController(nibName: nil, bundle: nil)
            listOfStringsViewController.title = "List of strings"
            let model = ListOfStringsViewModel(view: listOfStringsViewController)
            listOfStringsViewController.model = model
            presenter.pushViewController(listOfStringsViewController, animated: true)
        } else {
            let loginViewController = LoginViewController(nibName: nil, bundle: nil)
            loginViewController.title = "Login"
            let model = LoginViewModel(view: loginViewController)
            loginViewController.model = model
            presenter.pushViewController(loginViewController, animated: true)
        }
    }
}
