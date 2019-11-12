//
//  UserEntity.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import CoreData

@objc(UserEntity)
public class UserEntity:NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: String(describing: UserEntity.self))
    }

    @NSManaged public var address: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var lastname: String?
    @NSManaged public var name: String?
    @NSManaged public var postalcode: Int16
    @NSManaged public var town: String?

}

extension UserEntity {
    func update(user:User) {
        self.name = user.name
        self.lastname = user.lastname
        self.address = user.address
        self.postalcode = Int16(user.postalcode)
        self.town = user.town
        self.birthday = user.birthday
    }
}
