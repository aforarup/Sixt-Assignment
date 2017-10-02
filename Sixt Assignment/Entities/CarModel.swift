//
//  CarModel.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import Foundation
import ObjectMapper
import MapKit

enum Transmission: String {
    case Manual = "M"
    case Automatic = "A"
}

enum FuelType: String {
    case D
    case P
}

enum Cleanliness: String {
    case regular = "REGULAR"
    case clean = "CLEAN"
    case veryclean = "VERY_CLEAN"
}

struct CarModel {
    var id: String?
    var modelIdentifier: String?
    var modelName: String?
    var name: String?
    var make: String?
    var group: String?
    var color: String?
    var series: String?
    var fuelType: FuelType?
    var fuelLevel: Double?
    var transmission: Transmission?
    var licensePlate: String?
    var latitude: Double?
    var longitude: Double?
    var innerCleanliness: Cleanliness?
}

extension CarModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        modelIdentifier     <- map["modelIdentifier"]
        modelName           <- map["modelName"]
        make                <- map["make"]
        name                <- map["name"]
        group               <- map["group"]
        color               <- map["color"]
        series              <- map["series"]
        fuelType            <- map["fuelType"]
        fuelLevel           <- map["fuelLevel"]
        transmission        <- map["transmission"]
        licensePlate        <- map["licensePlate"]
        latitude            <- map["latitude"]
        longitude           <- map["longitude"]
        innerCleanliness    <- map["innerCleanliness"]
        
    }
}

struct CarListViewModel {
    let id: String?
    let imageUrl: URL?
    let makeModelDisplay: String?
    let licensePlateDisplay: String?
    let nameDisplay: String?
    let fuelTypeDisplay: String?
    let txTypeDisplay: String?
    let fuelMeterDisplay: String?
    let cleanlinessDisplay: String?
    init(with car: CarModel!) {
        self.id = car.id
        
        self.imageUrl = URL(string: "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\((car?.modelIdentifier)!)/\((car.color)!)/2x/car.png")
        
        if let make = car.make, let modelIdentifier = car.modelIdentifier {
            self.makeModelDisplay = make + " " + modelIdentifier
        } else {
            makeModelDisplay = ""
        }
        if let name = car.name {
            self.nameDisplay = name
        } else {
            self.nameDisplay = ""
        }
        
        if let fuelType = car.fuelType {
            switch fuelType {
                case .D:
                    fuelTypeDisplay = "Fuel: Diesel"
                case .P:
                    fuelTypeDisplay = "Fuel: Petrol"
            }
        } else {
            fuelTypeDisplay = ""
        }
        
        if let txType = car.transmission {
            switch txType {
            case .Manual:
                txTypeDisplay = "Transmission: Manual"
            case .Automatic:
                txTypeDisplay = "Transmission: Auto"
            }
        } else {
            txTypeDisplay = ""
        }
        
        if let fuelLevel = car.fuelLevel {
            self.fuelMeterDisplay = "Fuel Level: \(fuelLevel)"
        } else {
            self.fuelMeterDisplay = ""
        }
        
        if let licensePlate = car.licensePlate {
            self.licensePlateDisplay = licensePlate
        } else {
            self.licensePlateDisplay = ""
        }
        
        if let cleanliness = car.innerCleanliness {
            switch cleanliness {
            case .regular:
                cleanlinessDisplay = "Regular Clean"
            case .clean:
                cleanlinessDisplay = "Clean"
            case .veryclean:
                cleanlinessDisplay = "Very Clean"
            }
        } else {
            cleanlinessDisplay = ""
        }
    }
}

class CarAnnotation: NSObject, MKAnnotation {
    lazy var coordinate: CLLocationCoordinate2D = {
        guard let lati = self.latitude, let longi = self.longitude else {
            return kCLLocationCoordinate2DInvalid
        }
        return CLLocationCoordinate2DMake(lati, longi)
    }()
    
    var id: String?
    var latitude: Double?
    var longitude: Double?
    
    
    init(with carModel: CarModel?) {
        self.id = carModel?.id
        self.latitude = carModel?.latitude
        self.longitude = carModel?.longitude
    }
}
