//
//  CarManager.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit
import CoreData

class CarManager: NSObject {
    let coreDataStack:CoreDataStack
    
    public init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init()
    }
    
    func getSavedCars() -> [Car]? {
        var cars:[Car]? = [Car]()
        do {
            let results = try self.getContext().fetch(CarEntity.fetchRequest())
            for carEntity in results {
                let car = Car(carEntity: carEntity as! CarEntity)
                cars?.append(car)
            }
        } catch {
            return nil
        }
        
        return cars
    }
    
    func updateCars(cars:[Car]?) -> Bool {
        guard let cars = cars else {
            return false
        }
        self.removeAllCars()
        for car in cars {
            let carEntity = CarEntity(context: self.coreDataStack.managedContext)
            carEntity.update(car: car)
        }
        save()
        return true
    }
    
    func removeAllCars() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CarEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.coreDataStack.managedContext.execute(batchDeleteRequest)
        } catch {
            
        }
        save()
    }
    
    public func getContext() -> NSManagedObjectContext {
        return self.coreDataStack.managedContext
    }
    
    public func save() {
        self.coreDataStack.saveContext()
    }
    
    public func clear() {
        self.coreDataStack.clearContext()
    }
}
