//
//  DependancyInjectionCodeData.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 12/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

class DependancyInjectionCodeData: NSObject {
    static let shared: DependancyInjectionCodeData = DependancyInjectionCodeData()
    
    let sharedCoreDataStack = CoreDataStack(modelName: "TCTestProject")
    let sharedUserManager:UserManager
    let sharedCarManager:CarManager
    
    override init() {
        self.sharedUserManager = UserManager(coreDataStack: sharedCoreDataStack, pictureManager: PictureManager())
        self.sharedCarManager = CarManager(coreDataStack: sharedCoreDataStack)
    }
    
    func saveUser(user:User) -> Bool {
        return self.sharedUserManager.saveUser(user: user)
    }
    
    func getCurrentUser() -> User? {
        return self.sharedUserManager.getCurrentUser()
    }
    
    func getSavedCars() -> [Car]? {
        return self.sharedCarManager.getSavedCars()
    }
    
    func updateCars(cars:[Car]?) -> Bool {
        return self.sharedCarManager.updateCars(cars: cars)
    }
}
