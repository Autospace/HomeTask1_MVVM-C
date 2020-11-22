//
//  AppDelegate.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 20/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let appCoordinator = AppCoordinator(window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
        return true
    }

}
