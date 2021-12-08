//
//  AppointmentDao.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-08.
//

import Foundation

class AppointmentDao{
    
    init(id: String, activeMedication: String, consultationFor: String, date: String, healthCondition: String, PatientID: String, docName: String, patientName: String, location: String) {
        self.id = id
        self.activeMedication = activeMedication
        self.consultationFor = consultationFor
        self.date = date
        self.healthCondition = healthCondition
        self.PatientID = PatientID
        self.docName = docName
        self.patientName = patientName
        self.location = location
    }
    
      
    
    
    
    var id:String
    var activeMedication:String
    var consultationFor:String
    var date:String
    var healthCondition:String
    var PatientID:String
    var docName:String
    var patientName:String
    var location:String
    
    
}
