//
//  UserManager.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import CoreData

class UserManager: NSObject {
    let coreDataStack:CoreDataStack
    let pictureManager:PictureManagerProtocol
    
    public init(coreDataStack: CoreDataStack, pictureManager:PictureManagerProtocol) {
        self.coreDataStack = coreDataStack
        self.pictureManager = pictureManager
        super.init()
    }
    
    public func saveUser(user:User) -> Bool{
        let userEntity:UserEntity
        do {
            let results = try self.getContext().fetch(UserEntity.fetchRequest())
            if let currentUserEntity = results.first {
                userEntity = currentUserEntity as! UserEntity
            }
            else {
                userEntity  = UserEntity(context: self.coreDataStack.managedContext)
            }
        } catch {
           userEntity  = UserEntity(context: self.coreDataStack.managedContext)
        }
        userEntity.update(user: user)
        save()
        return self.pictureManager.saveImage(name: profileImageFilename, imageData: user.profil)
    }
    
    public func getCurrentUser() -> User? {
        var user:User?
        do {
            let results = try self.getContext().fetch(UserEntity.fetchRequest())
            if let userEntity = results.first {
                user = User(userEntity: userEntity as! UserEntity)
                user?.profil = self.pictureManager.getImageData(name: profileImageFilename)
            }
        } catch {
            return nil
        }
        
        return user
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
