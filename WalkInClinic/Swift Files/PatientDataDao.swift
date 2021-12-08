//
//  PatientDataDao.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-07.
//

import Foundation

class PatientDataDao:NSObject {
    
    var dob: String
    var hcard: String
    var height: String
    var weight: String
    var familyDoctor: String
    var healthCondition: String
    var medication: String
    
     init(dob:String,hcard:String,height:String, weight:String, familyDoctor:String, healthCondition:String, medication:String) {
        self.dob = dob
        self.hcard = hcard
        self.height = height
        self.weight = weight
        self.familyDoctor = familyDoctor
        self.healthCondition = healthCondition
        self.medication = medication
    }
    
    override init() {
       self.dob = ""
       self.hcard = ""
       self.height = ""
       self.weight = ""
       self.familyDoctor = ""
       self.healthCondition = ""
       self.medication = ""
   }
   
}
