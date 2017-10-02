//
//  Interacter.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation

protocol InteractionListener {
    func selectedCar(with id: String, in view: DisplayRouterType)
}


struct Event {
    
    var context : DisplayRouterType?
    var carId : String?
    
    init(for carId : String?, context : DisplayRouterType?) {
        self.carId = carId
        self.context = context
    }
}

protocol EventListener {
    
    func eventChanged(forEvent event : Event)
}

class Interactor {
    
    var eventListeners : [EventListener]?
    
    func setEventListener(listener : EventListener) {
        
        if (self.eventListeners == nil) {
            
            self.eventListeners = []
        }
        
        self.eventListeners?.append(listener)
    }
    
    func postEvent(event : Event) {
        
        if let eventListeners = self.eventListeners {
            for listener in eventListeners {
                
                listener.eventChanged(forEvent: event)
            }
        }
    }
}

