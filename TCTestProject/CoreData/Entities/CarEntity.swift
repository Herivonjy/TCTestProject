//
//  CarEntity.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

extension CarEntity {
    func update(car:Car) {
        self.make = car.make
        self.model = car.model
        self.year = Int16(car.year)
        self.equipments = car.equipments as NSObject?
    }
}
