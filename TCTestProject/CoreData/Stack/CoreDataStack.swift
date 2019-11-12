//
//  CoreDataStack.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import Foundation
import CoreData

public enum CoreDataStackError: Error {
    case loadResource
    case managerObjectModel
    case migrationUrlNotFound
    case migration(Error)
}

open class CoreDataStack: NSObject {
    
    let modelName: String
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    public lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    public func clearContext() {
        let persistences = storeContainer.persistentStoreCoordinator.persistentStores
        for persistenceStore in persistences {
            if let persistentStoreURL = storeContainer.persistentStoreCoordinator.url(for: persistenceStore) as URL? {
                do {
                    try storeContainer.persistentStoreCoordinator.destroyPersistentStore(at: persistentStoreURL, ofType: NSSQLiteStoreType, options: nil)
                    
                } catch {
                    fatalError("Error occured : \(error.localizedDescription)")
                }
            }
        }
    }
}
