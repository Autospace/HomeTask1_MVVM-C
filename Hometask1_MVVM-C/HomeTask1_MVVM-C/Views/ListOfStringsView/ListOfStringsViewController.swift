//
//  ListOfStringsViewController.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import UIKit

protocol ListOfStringsViewInterface: class {
    func showListOfStrings(strings: String)
    func showError(with message: String)
}

class ListOfStringsViewController: UIViewController {
    @IBOutlet private var listOfStringsLabel: UILabel!
    var model: ListOfStringsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model?.loadData()
    }
    
    @IBAction func tapOnLogoutButton() {
        model?.logout()
    }
    
}

extension ListOfStringsViewController: ListOfStringsViewInterface {
    func showListOfStrings(strings: String) {
        listOfStringsLabel.text = strings
    }

    func showError(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
