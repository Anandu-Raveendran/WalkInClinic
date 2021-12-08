//
//  PatientsHomeViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-07.
//

import UIKit

class PatientsHomeViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var appointmentTableView: UITableView!
    
    var patientDetails:PatientDataDao? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let uid = AppManager.shared.loggedInUID {
            
        let docRef = AppManager.shared.db.collection("users").document(uid)
        
        docRef.getDocument{
        (document, error) in
                       
            if let document = document, document.exists {
                
                let data = document.data()
                
                self.patientDetails = PatientDataDao()
                self.patientDetails?.hcard = data?["hcard"] as? String ?? ""
                self.patientDetails?.dob = data?["dob"] as? String ?? ""
                self.patientDetails?.weight = data?["weight"] as? String ?? ""
                self.patientDetails?.height = data?["height"] as? String ?? ""
                self.patientDetails?.familyDoctor = data?["familyDoc"] as? String ?? ""
                self.patientDetails?.healthCondition = data?["healthCondition"] as? String ?? ""
                self.patientDetails?.medication = data?["medication"] as? String ?? ""
                
                print("retrieved patient data for \(String(describing: self.patientDetails?.hcard))")
                self.userName.text = AppManager.shared.userData?.name
                self.location.text = self.patientDetails?.hcard
            } else {
                print("Patient Document does not exit for uid \(uid)")
            }
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addAppointmentBtn(_ sender: UIButton) {
        
    }
}
