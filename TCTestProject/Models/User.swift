//
//  User.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

struct User {
    let name:String?
    let lastname:String?
    let address:String?
    let postalcode:Int
    let town:String?
    let birthday:Date?
    var profil:Data?
    
    init(userEntity:UserEntity) {
        self.name = userEntity.name
        self.lastname = userEntity.lastname
        self.address = userEntity.address
        self.postalcode = Int(userEntity.postalcode)
        self.town = userEntity.town
        self.birthday = userEntity.birthday
    }
    
    init(name:String?, lastname:String?, address:String?, postalcode:Int, town:String?, birthday:Date?, profil:Data?) {
        self.name = name
        self.lastname = lastname
        self.address = address
        self.postalcode = postalcode
        self.town = town
        self.birthday = birthday
        self.profil = profil
    }
    
    
}
