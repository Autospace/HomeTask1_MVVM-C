//
//  AppCoordinator.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let loginCoordinator: LoginCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        loginCoordinator = LoginCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        loginCoordinator.start()
        window.makeKeyAndVisible()
    }
}
