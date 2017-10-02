//
//  MapBuilder.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

import UIKit

class MapBuilder : Builder {
    
    override func build() -> Riblet {
        
        let router = MapRouter()
        
        let interactor = MapInteractor()
        interactor.router = router
        
        let presenter = MapPresenter()
        presenter.presenterOuput = interactor
        interactor.interactorOutput = presenter
        
        let listRiblet = Riblet(router: router, interactor: interactor, builder: self)
        router.riblet = listRiblet
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            
            vc.presenter = presenter
            presenter.viewInput = vc
            listRiblet.viewController = vc
        }
        
        
        return listRiblet
    }
    
    override func build(parentInteractor : Interactor) -> Riblet {
        let riblet = self.build()
        
        if let interactor = riblet.interactor as? MapInteractor {
            parentInteractor.setEventListener(listener: interactor)
            
            if let mapListener = parentInteractor as? InteractionListener {
                interactor.delegate = mapListener
            }
        }
        
        return riblet
    }
}
