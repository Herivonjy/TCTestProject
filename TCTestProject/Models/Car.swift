//
//  Car.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//


struct Car: Codable {
    var make:String?
    var model:String?
    var year:Int
    var picture:String?
    var equipments:[String]?
    
    init(carEntity:CarEntity) {
        self.make = carEntity.make
        self.model = carEntity.model
        self.year = Int(carEntity.year)
        self.picture = carEntity.picture
        self.equipments = carEntity.equipments as? [String]
    }
}
