//
//  PatientDataDao.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-07.
//

import Foundation

class PatientDataDao:UserDataDao {
    
    init(name: String = "", phone: Int64 = 0, address: String = "", zipcode: String = "", role: String = "", email: String = "", uid: String = "",
         dob: String = "", hcard: String = "", height: String = "", weight: String = "", familyDoctor: String = "", healthCondition: String = "", medication: String = "") {
        self.dob = dob
        self.hcard = hcard
        self.height = height
        self.weight = weight
        self.familyDoctor = familyDoctor
        self.healthCondition = healthCondition
        self.medication = medication
        super.init(name: name, phone: phone, address: address, zipcode: zipcode, role: role, email: email, uid: uid)
    }
    
    var dob: String = ""
    var hcard: String = ""
    var height: String = ""
    var weight: String = ""
    var familyDoctor: String = ""
    var healthCondition: String = ""
    var medication: String = ""
    
}
