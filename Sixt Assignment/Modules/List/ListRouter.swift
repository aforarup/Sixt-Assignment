//
//  ListRouter.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

enum DisplayRouterType: Int {
    case list
    case map
}

class ListRouter: Router {
    func attachView(routeType : DisplayRouterType){
        
        switch routeType {
        case .map:
            
            let mapBuilder = MapBuilder()
            
            let mapRiblet = mapBuilder.build()
            
            let context = Context(hashValue: routeType.rawValue)
            self.addChild(context: context, riblet: mapRiblet)
            
            if let childVC = mapRiblet.viewController {
                
                self.riblet?.viewController?.navigationController?.pushViewController(childVC, animated:true)
            }
            
        default:
            print("Route not supported yet!")
        }
    }
}
