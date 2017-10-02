//
//  HomeBuilder.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

import UIKit

class HomeBuilder : Builder {
    
    override func build() -> Riblet {
        
        let router = HomeRouter()
        
        let interactor = HomeInteractor()
        interactor.router = router
        
        let presenter = HomePresenter()
        presenter.presenterOutput = interactor
        interactor.interactorOutput = presenter
        
        let listRiblet = Riblet(router: router, interactor: interactor, builder: self)
        router.riblet = listRiblet
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            
            vc.presenter = presenter
            presenter.view = vc
            listRiblet.viewController = vc
        }
        
        
        return listRiblet
    }
    
    override func build(parentInteractor : Interactor) -> Riblet {
        let riblet = self.build()
        return riblet
    }
}
