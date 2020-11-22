//
//  LoginViewController.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction private func tapOnLoginButton() {
        view.endEditing(false)
    }
}
