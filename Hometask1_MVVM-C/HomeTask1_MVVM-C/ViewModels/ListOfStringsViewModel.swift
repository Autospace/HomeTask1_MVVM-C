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
        let networkService = NetworkService()
        networkService.fetchStrings {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError(with: error.localizedDescription)
                }
            case .success(let stringData):
                DispatchQueue.main.async {
                    self.view?.showListOfStrings(strings: stringData)
                }
            }
        }
    }
    
    func logout() {
        flowCoordinator?.logout()
    }
}
