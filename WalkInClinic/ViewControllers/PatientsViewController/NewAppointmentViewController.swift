//
//  NewAppointmentViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-08.
//

import UIKit

class NewAppointmentViewController: UIViewController {

    var selectedDoctor:DoctorDataDao? = nil
    var date:String = ""
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dpimage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var specification: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var consultation: UILabel!
    
    
    @IBOutlet weak var consultationFor: UITextView!
    
    @IBOutlet weak var healthCondition: UITextView!
    
    @IBOutlet weak var activeMedication: UITextView!
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()

           dateFormatter.dateStyle = DateFormatter.Style.short
           dateFormatter.timeStyle = DateFormatter.Style.short

           let strDate = dateFormatter.string(from: datePicker.date)
           date = strDate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        datePickerChanged(datePicker)
       
        name.text = selectedDoctor?.name
        specification.text = selectedDoctor?.specialisation
        var str:String = ""
        if(selectedDoctor?.days[0] ?? false ){
            str += "Sun "
        }
        if(selectedDoctor?.days[1] ?? false){
            str += "Mon "
        }
        if(selectedDoctor?.days[2] ?? false){
            str += "Tue "
        }
        if(selectedDoctor?.days[3] ?? false){
            str += "Wed "
        }
        if(selectedDoctor?.days[4] ?? false){
            str += "Thu "
        }
        if(selectedDoctor?.days[5] ?? false){
            str += "Fri "
        }
        if(selectedDoctor?.days[6] ?? false){
            str += "Sat"
        }
        consultation.text = str
        location.text = selectedDoctor?.clinicAdd
        
    }
    @IBAction func bookBtn(_ sender: Any) {
        AppManager.shared.db.collection("appointment").document(selectedDoctor!.uid).setData([
            "date": date,
            "patient": AppManager.shared.loggedInUID,
            "patientName": AppManager.shared.userData?.name,
            "docName": selectedDoctor?.name,
            "location": selectedDoctor?.clinicAdd,
            "consultationFor": consultationFor.text,
            "healthCondition": healthCondition.text,
            "activemedication": activeMedication.text ])
        {
            error in
            
            if(error != nil){
                print("appointment data create error \(String(describing: error?.localizedDescription))")
            } else {
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }


    
}
