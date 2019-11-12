//
//  CarEntity.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import CoreData

@objc(CarEntity)
public class CarEntity:NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var equipments: NSObject?
    @NSManaged public var make: String?
    @NSManaged public var model: String?
    @NSManaged public var picture: String?
    @NSManaged public var year: Int16
    
    
}

extension CarEntity {
    func update(car:Car) {
        self.make = car.make
        self.model = car.model
        self.year = Int16(car.year)
        self.equipments = car.equipments as NSObject?
    }
}
