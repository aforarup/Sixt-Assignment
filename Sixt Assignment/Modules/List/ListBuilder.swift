//
//  ListBuilder.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

import UIKit

class ListBuilder : Builder {
    
    override func build() -> Riblet {
        
        let router = ListRouter()
        
        let interactor = ListInteractor()
        interactor.router = router
        
        let presenter = ListPresenter()
        presenter.presenterOutput = interactor
        interactor.interactorOutput = presenter
        
        let listRiblet = Riblet(router: router, interactor: interactor, builder: self)
        router.riblet = listRiblet
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
            
            vc.presenter = presenter
            presenter.viewInput = vc
            listRiblet.viewController = vc
        }
       
        
        return listRiblet
    }
    
    override func build(parentInteractor : Interactor) -> Riblet {
        let riblet = self.build()
        
        if let listInteractor = riblet.interactor as? ListInteractor {
            
            parentInteractor.setEventListener(listener: listInteractor)
            if let listListener = parentInteractor as? InteractionListener {
                listInteractor.delegate = listListener
            }
            
        }
        
        return riblet
    }
}
