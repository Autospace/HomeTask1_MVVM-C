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
    let networkService: NetworkService
    weak var view: ListOfStringsViewInterface?
    weak var flowCoordinator: FlowCoordinatorDelegate?
    
    init(view: ListOfStringsViewInterface, flowCoordinatorDelegate: FlowCoordinatorDelegate, networkService: NetworkService = NetworkService()) {
        self.view = view
        self.flowCoordinator = flowCoordinatorDelegate
        self.networkService = networkService
    }
}

extension ListOfStringsViewModel: ListOfStringsViewModelDelegate {
    func loadData() {
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
