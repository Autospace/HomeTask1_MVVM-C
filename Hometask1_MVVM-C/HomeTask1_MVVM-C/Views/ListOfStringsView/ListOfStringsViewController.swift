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
    @IBOutlet private var scrollView: UIScrollView!

    var model: ListOfStringsViewModel?
    lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        model?.loadData()
    }
    
    @IBAction private func tapOnLogoutButton() {
        model?.logout()
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }

    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        model?.loadData()
    }
}

extension ListOfStringsViewController: ListOfStringsViewInterface {
    func showListOfStrings(strings: String) {
        listOfStringsLabel.text = strings
        refreshControl.endRefreshing()
    }

    func showError(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
