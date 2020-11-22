//
//  ListOfStringsViewModel.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import Foundation

protocol ListOfStringsViewModelDelegate: class {
    func loadData()
    func logout()
}

class ListOfStringsViewModel {
    weak var view: ListOfStringsViewInterface?
    weak var flowCoordinator: FlowCoordinatorDelegate?
    
    init(view: ListOfStringsViewInterface, flowCoordinatorDelegate: FlowCoordinatorDelegate) {
        self.view = view
        self.flowCoordinator = flowCoordinatorDelegate
    }
}

extension ListOfStringsViewModel: ListOfStringsViewModelDelegate {
    func loadData() {
        // TODO: implement network request
        let strings = "stub\nlist\nof strings"
        view?.showListOfStrings(strings: strings)
    }
    
    func logout() {
        flowCoordinator?.logout()
    }
}
