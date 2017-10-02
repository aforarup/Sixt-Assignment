//
//  Builder.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

protocol BuilderProtocol {
    func build() -> Riblet
}

class Builder : BuilderProtocol  {
    
    func build() -> Riblet {
        
        abort()
    }
    
    func build(parentInteractor : Interactor) -> Riblet {
        
        abort()
    }
    
}

