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
    var selectedAppointment:AppointmentDao? = nil
    var isDoc = false
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var subheading: UILabel!
    @IBOutlet weak var bookBtn: UIButton!
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
    
    @IBOutlet weak var deleteBtnref: UIButton!
    @IBAction func DeleteBtnAction(_ sender: Any) {
        if let id = selectedAppointment?.id {
            AppManager.shared.db.collection("appointment").document(id).delete() {
                err in
                if err != nil {
                print("Error removing data")
            } else {
                print("Deleted data")
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        isDoc = AppManager.shared.userData?.role == "doctor"
        if(selectedAppointment != nil || isDoc){
            heading.text = "Appointment Details"
            subheading.text = "Details of your Appointment"
            consultationFor.text = selectedAppointment?.consultationFor
            healthCondition.text = selectedAppointment?.healthCondition
            activeMedication.text = selectedAppointment?.activeMedication
            if(isDoc){
                bookBtn.titleLabel?.text = "Complete"
            } else {
                bookBtn.titleLabel?.text = "Update"
            }
            deleteBtnref.isHidden = false
        } else {
            deleteBtnref.isHidden = true
            datePickerChanged(datePicker)
        }
        name.text = selectedDoctor?.name
        specification.text = selectedDoctor?.specialisation
        AppManager.shared.getImageFirebase(for_uid: selectedDoctor?.uid ?? "", callback: gotImageCallback )
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
    
    func gotImageCallback(imageData:Data?){
        if let imageData = imageData {
            self.dpimage.image = UIImage(data:imageData)
            AppManager.shared.dpImage = UIImage(data:imageData)
        }
    }
    
    @IBAction func bookBtn(_ sender: Any) {
    
        var statusText = "Under doctors review"
        if isDoc {
            statusText = "Completed"
        }
        AppManager.shared.db.collection("appointment").document(UUID().uuidString).setData([
            "date": date,
            "patient": AppManager.shared.loggedInUID,
            "patientName": AppManager.shared.userData?.name,
            "docName": selectedDoctor?.name,
            "location": selectedDoctor?.clinicAdd,
            "consultationFor": consultationFor.text,
            "healthCondition": healthCondition.text,
            "activemedication": activeMedication.text,
            "docID":selectedDoctor!.uid,
            "status":statusText])
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
