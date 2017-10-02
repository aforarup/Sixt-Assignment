//
//  HomeInteractor.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

protocol HomeInteractorOutput {
    func dataFetched (_ cars: [CarModel])
    func dataFetchFailed(with error: Error)
}

class HomeInteractor: Interactor {
    var router : HomeRouter?
    var interactorOutput : HomeInteractorOutput?
    
}

extension HomeInteractor: HomePresenterOutput {
    func fetchData() {
        CarsDownloadService().getCars(completionHandler: {
            [unowned self](cars: [CarModel]?, error: Error?) in
            if let err = error {
                self.interactorOutput?.dataFetchFailed(with: err)
                return
            }
            self.interactorOutput?.dataFetched(cars!)
        })
    }
    
    func attachViews() {
        self.router?.attachView(routeType: .map)
        self.router?.attachView(routeType: .list)
    }
}

extension HomeInteractor: InteractionListener {
    func selectedCar(with id: String, in view: DisplayRouterType) {
        let carSelectionEvent = Event.init(for: id, context: view)
        postEvent(event: carSelectionEvent)
    }
}
