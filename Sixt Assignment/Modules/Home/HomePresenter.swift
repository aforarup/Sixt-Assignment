//
//  HomePresenter.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

protocol HomePresenterOutput {
    func fetchData()
    func attachViews()
}

class HomePresenter {
    var view: HomeViewInput?
    var presenterOutput: HomePresenterOutput?
}

extension HomePresenter: HomeViewOutput {
    func setUpView() {
        self.presenterOutput?.fetchData()
    }
    
    func connectViews() {
        self.presenterOutput?.attachViews()
    }
}

extension HomePresenter : HomeInteractorOutput {
    func dataFetchFailed(with error: Error) {
        fatalError()
    }
    
    func dataFetched (_ cars: [CarModel]) {
        self.view?.prepareForViewing()
    }
    
}
