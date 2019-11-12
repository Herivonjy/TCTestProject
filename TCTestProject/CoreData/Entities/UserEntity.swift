//
//  UserEntity.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import CoreData

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
