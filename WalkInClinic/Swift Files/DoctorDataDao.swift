//
//  DoctorDataDao.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-07.
//

import Foundation

class DoctorDataDao: UserDataDao {
    
    init(name: String = "", phone: Int64 = 0, address: String = "", zipcode: String = "", role: String = "", email: String = "", uid: String = "",clinicName: String = "", specialisation: String = "", clinicAdd: String = "", college: String = "", passYear: String = "", consultationTime: String = "", days: [Bool] = [false,false,false,false,false,false,false]) {
        self.clinicName = clinicName
        self.specialisation = specialisation
        self.clinicAdd = clinicAdd
        self.college = college
        self.passYear = passYear
        self.consultationTime = consultationTime
        self.days = days
        super.init(name: name, phone: phone, address: address, zipcode: zipcode, role: role, email: email, uid: uid)
    }
    
    var clinicName:String = ""
    var specialisation:String = ""
    var clinicAdd:String = ""
    var college:String = ""
    var passYear:String = ""
    var consultationTime:String = ""
    var days:[Bool] = [false,false,false,false,false,false,false]

}

