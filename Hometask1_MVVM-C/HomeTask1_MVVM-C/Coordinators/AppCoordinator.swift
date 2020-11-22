//
//  AppCoordinator.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    let navigationController: UINavigationController
    let flowCoordinator: FlowCoordinator
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        flowCoordinator = FlowCoordinator(presenter: navigationController)
    }
    
    func start() {
        window.rootViewController = navigationController
        flowCoordinator.start()
        window.makeKeyAndVisible()
    }
}
