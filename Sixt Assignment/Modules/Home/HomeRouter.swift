//
//  HomeRouter.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

class HomeRouter: Router {
    func attachView(routeType : DisplayRouterType){
        var builder: Builder?
        
        switch routeType {
        case .map:
            
            builder = MapBuilder()
            
        case .list:
            builder = ListBuilder()
          
        }
        
        var riblet: Riblet?
        if let interactor = self.riblet?.interactor  {
            riblet = builder?.build(parentInteractor: interactor)
        } else {
            riblet = builder?.build()
        }
        
        
        
        let context = Context(hashValue: routeType.rawValue)
        self.addChild(context: context, riblet: riblet!)
        
        if let childVC = riblet?.viewController {
            
            (self.riblet?.viewController as! HomeViewController).attach(viewController: childVC, for: routeType)
        }
    }
    
    func detachView(routeType : DisplayRouterType) {
        
//        switch routeType {
//        case .edit:
//            
//            let context = Context(hashValue: routeType.rawValue)
//            
//            if let riblet = self.childRiblet(context: context) {
//                
//                riblet.viewController?.dismiss(animated: true, completion: {
//                    
//                    self.removeChild(context: context)
//                })
//            }
//            
//        default:
//            print("Route not supported yet!")
//        }
    }
}
