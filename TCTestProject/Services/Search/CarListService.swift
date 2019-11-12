//
//  CarListService.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import Foundation
import Reachability

class CarListService {
    func getAllCars(completion: @escaping ([Car]?, Error?) -> ()) {
        
        HttpManager.fetchCars { (cars, error) in
            completion(cars,error)
            let _ = DependancyInjectionCodeData.shared.updateCars(cars: cars)
        }
        
        let cars = DependancyInjectionCodeData.shared.getSavedCars()
        completion(cars,nil)
    }
}
