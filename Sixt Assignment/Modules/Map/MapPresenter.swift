//
//  MapPresenter.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation
import MapKit

enum MapConstants {
    static let defaultMapRadius = 4000.0
    static let defaultViewRadius = 100.0
    
}

enum MapIdentifierConstants {
    static let annotationViewIdentifier = "marker"
}

protocol MapPresenterOutput {
    func fetchData()
    func informToShowCar(with id: String)
}

class MapPresenter {
    var presenterOuput : MapPresenterOutput?
    var viewInput : MapViewInput?
    var annotations: [CarAnnotation]?
}

extension MapPresenter {
    // MARK:- Behaviours
    func centerMap(for cars:[CarModel]?) {
        if annotations == nil { addAnnotations(cars!) }
        let center = findCenter(of: annotations!.map{$0.coordinate})
        self.viewInput?.moveMap(to: center, radiusInMeters: MapConstants.defaultMapRadius)
    }
    
    func addAnnotations(_ cars: [CarModel]) {
        self.annotations = cars.map {
            CarAnnotation(with: $0)
        }
        self.viewInput?.addAnnotations(annotations)
    }
    
    func findCenter(of locations: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        
        if locations.count == 0 {
            return CLLocationCoordinate2DMake(0.0, 0.0)
            
        }
        
        let locSum: (Double, Double) = locations.filter{CLLocationCoordinate2DIsValid($0)}.reduce((0, 0)) {
            return ($0.0 + $1.latitude, $0.1 + $1.longitude)
        }
        
        return CLLocationCoordinate2DMake(locSum.0/Double(locations.count), locSum.1/Double(locations.count))
    }
    
    func getAnnotation(for id:String) -> CarAnnotation? {
        return self.annotations?.first{
            $0.id == id
        }
    }
    
    func moveMap(toShow carAnnotation: CarAnnotation) {
        self.viewInput?.moveMap(to: carAnnotation.coordinate, radiusInMeters: MapConstants.defaultViewRadius)
    }
    
    func getAnnotationView(with dequeuedView: MKAnnotationView?, for annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CarAnnotation else { return nil }
        
        var view : MKAnnotationView!
        
        if let dequeuedView = dequeuedView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        
        } else {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: MapIdentifierConstants.annotationViewIdentifier)
        }
    
    
        view.canShowCallout = false
        view.image = UIImage(named: "car_annotation")
        
        return view
    }
    
}

extension MapPresenter : MapInteractorOutput {
    func moveMapToShowCarAnnotation(with id: String) {
        let annotation = getAnnotation(for: id)
        
        if let annotation = annotation {
            self.moveMap(toShow: annotation)
        }
    }
    
    func dataFetchFailed(with error: Error) {
        fatalError()
    }
    
    func dataFetched (_ cars: [CarModel]) {
        self.addAnnotations(cars)
        self.centerMap(for: cars)
    }
    
}

extension MapPresenter: MapViewOutput {
    func selectedCar(with annotation: CarAnnotation) {
        if let id = annotation.id {
            self.presenterOuput?.informToShowCar(with: id)
        }
    }
    
    
    func setUpView() {
        self.presenterOuput?.fetchData()
    }
}
