//
//  MapInteractor.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

protocol MapInteractorOutput {
    func dataFetched (_ cars: [CarModel])
    func dataFetchFailed(with error: Error)
    
    func moveMapToShowCarAnnotation(with id: String)
}

class MapInteractor: Interactor {
    var router : MapRouter?
    var interactorOutput : MapInteractorOutput?
    var delegate: InteractionListener?
}

extension MapInteractor {
    
    // MARK:- Behaviours
    func bringCarInView(_ id: String) {
        self.interactorOutput?.moveMapToShowCarAnnotation(with: id)
    }
}

extension MapInteractor: MapPresenterOutput {
    func informToShowCar(with id: String) {
        self.delegate?.selectedCar(with: id, in: .map)
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

extension MapInteractor: EventListener {
    func eventChanged(forEvent event: Event) {
        switch event.context {
        case .map? :
            return
        default:
            if let carId = event.carId {
                self.bringCarInView(carId)
            }
        }
    }
}

