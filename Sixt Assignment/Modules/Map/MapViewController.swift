//
//  MapViewController.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation
import MapKit

protocol MapViewInput {
    func addAnnotations(_ annotations: [MKAnnotation]?)
    func moveMap(to location: CLLocationCoordinate2D, radiusInMeters: Double?)
}

protocol MapViewOutput {
    func setUpView()
    func selectedCar(with annotation: CarAnnotation)
    
    func getAnnotationView(with dequeuedView: MKAnnotationView?, for annotation: MKAnnotation) -> MKAnnotationView?
}

class MapViewController: UIViewController {
    
    // MARK:- Properties
    
    var presenter : MapViewOutput?
    
    @IBOutlet weak var mapView: MKMapView!
    
}

extension MapViewController {
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.setUpView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



extension MapViewController: MapViewInput {
    func moveMap(to location: CLLocationCoordinate2D, radiusInMeters: Double?) {
        self.mapView?.setRegion(MKCoordinateRegionMakeWithDistance(location, radiusInMeters!, radiusInMeters!), animated: true)
    }
    
    
    func addAnnotations(_ annotations: [MKAnnotation]?) {
        if let mapAnnotations = annotations {
            self.mapView?.addAnnotations(mapAnnotations)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = MapIdentifierConstants.annotationViewIdentifier
        
        let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        return self.presenter?.getAnnotationView(with: dequeuedView, for: annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.presenter?.selectedCar(with: view.annotation as! CarAnnotation)
        mapView.deselectAnnotation(view.annotation, animated: false)
    }
    
}


