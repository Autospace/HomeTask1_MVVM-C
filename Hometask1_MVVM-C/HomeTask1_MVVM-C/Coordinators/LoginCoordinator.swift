//
//  LoginCoordinator.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import UIKit

class LoginCoordinator: Coordinator {
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
        loginViewController.title = "Login"
        presenter.pushViewController(loginViewController, animated: true)
    }
}
