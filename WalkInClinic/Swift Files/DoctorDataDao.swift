//
//  DoctorDataDao.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-07.
//

import Foundation

class DoctorDataDao: NSObject {
    var clinicName:String
    var specialisation:String
    var clinicAdd:String
    var college:String
    var passYear:String
    var consultationTime:String
    var days:[Bool] = [false,false,false,false,false,false,false]
    
    init(clinicName:String,
     specialisation:String,
     clinicAdd:String,
     college:String,
     passYear:String,
     consultationTime:String,
     days:[Bool] ){
        
        self.clinicName = clinicName
        self.specialisation = specialisation
        self.clinicAdd = clinicAdd
        self.college = college
        self.passYear = passYear
        self.consultationTime = consultationTime
        self.days = days
    }
    
    override init(){
        
        self.clinicName = ""
        self.specialisation = ""
        self.clinicAdd = ""
        self.college = ""
        self.passYear = ""
        self.consultationTime = ""
        self.days[0] = false
        self.days[1] = false
        self.days[2] = false
        self.days[3] = false
        self.days[4] = false
        self.days[5] = false
        self.days[6] = false

    }
}

