//
//  UserDataDao.swift
//  BusinessCard
//
//  Created by Nandu on 2021-10-25.
//

import Foundation

class UserDataDao{
    
    init(name: String = "", phone: Int64 = 0, address: String = "", zipcode: String = "", role: String = "", email: String = "", uid: String = "") {
        self.name = name
        self.phone = phone
        self.address = address
        self.zipcode = zipcode
        self.role = role
        self.email = email
        self.uid = uid
    }
    
    var name:String = ""
    var phone:Int64 = 0
    var address:String = ""
    var zipcode:String = ""
    var role:String = ""
    var email:String = ""
    var uid:String = ""
    
}
