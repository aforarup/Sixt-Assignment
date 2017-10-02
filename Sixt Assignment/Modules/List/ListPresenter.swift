//
//  ListPresenter.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import UIKit

protocol ListPresenterOutput {
    func fetchData()
    func informToShowCar(with id: String)
}

class ListPresenter {
    var presenterOutput : ListPresenterOutput?
    var viewInput : ListViewInput?
    var cars: [CarModel]?
    var listViewModel: [CarListViewModel]?
}

extension ListPresenter : ListInteractorOutput {
    func scrollListToShowCar(with id: String) {
        let index = self.listViewModel?.index{$0.id == id}
        
        if let index = index {
            self.viewInput?.scrollTo(IndexPath.init(row: index, section: 0), true)
        }
    }
    
    func dataFetchFailed(with error: Error) {
        fatalError()
    }
    
    func dataFetched (_ cars: [CarModel]) {
        self.cars = cars
        self.listViewModel = cars.map {
            CarListViewModel(with: $0)
        }
        self.viewInput?.refreshView()
    }
}

extension ListPresenter: ListViewOutput {
    func signalVisibleItemChanged(to indexPath: IndexPath) {
        guard let id = cars?[indexPath.item].id else { return }
        self.presenterOutput?.informToShowCar(with: id)
    }
    
    
    func setUpView() {
        self.presenterOutput?.fetchData()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int? {
        if section == 0 {
            return self.listViewModel?.count ?? 0
        }
        return 0
    }
    
    func viewModelForIndexPath(for index: IndexPath) -> CarListViewModel? {
        return self.listViewModel?[index.item]
    }
}
