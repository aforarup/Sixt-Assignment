//
//  AppDependency.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation
import UIKit

class AppDependencies {
    
    var rootRiblet : Riblet?
    
    func configRootView(window : UIWindow, forLaunchOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]? ) {
        
        let builder = HomeBuilder()
        let riblet = builder.build()
        self.rootRiblet = riblet
        
        
        if let vc = riblet.viewController {
            
//            let navController = UINavigationController(rootViewController: vc)
            
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
}
