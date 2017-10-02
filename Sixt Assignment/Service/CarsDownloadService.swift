//
//  CarsDownloadService.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CarsDownloadService {
    
    let urlString = "http://www.codetalk.de/cars.json"
    fileprivate static var cars:[CarModel]?
    
    func getCars(completionHandler: @escaping (_ result: [CarModel]?, _ error: Error? )->()) {
        
        if let unbindCars = CarsDownloadService.cars {
            completionHandler(unbindCars, nil)
            
            return
        }
        downloadTask(completionHandler: completionHandler)
        
    }
    
    
    
    private func downloadTask(completionHandler: @escaping (_ result: [CarModel]?, _ error: Error? )->()) {
        
        
        
        Alamofire
            .request(urlString, method: .get).validate()
            .responseArray(completionHandler: {
                (response: DataResponse<[CarModel]>) in
                debugPrint(response)
                switch response.result {
                case .success(let cars):
                    CarsDownloadService.cars = cars
                    completionHandler(cars, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
            })
    }
}
