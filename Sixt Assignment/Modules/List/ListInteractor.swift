//
//  ListInteractor.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import UIKit

protocol ListInteractorOutput {
    func dataFetched (_ cars: [CarModel])
    func dataFetchFailed(with error: Error)
    func scrollListToShowCar(with id: String)
}

class ListInteractor: Interactor {
    var router : ListRouter?
    var interactorOutput : ListInteractorOutput?
    var delegate : InteractionListener?
}

extension ListInteractor {
    
    // MARK:- Behaviours
    func bringCarInView(_ id: String) {
        self.interactorOutput?.scrollListToShowCar(with: id)
    }
}

extension ListInteractor: ListPresenterOutput {
    func informToShowCar(with id: String) {
        self.delegate?.selectedCar(with: id, in: .list)
    }
    
    
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
}

extension ListInteractor: EventListener {
    func eventChanged(forEvent event: Event) {
        switch event.context {
        case .list? :
            return
        default:
            if let carId = event.carId {
                self.bringCarInView(carId)
            }
        }
    }
}
