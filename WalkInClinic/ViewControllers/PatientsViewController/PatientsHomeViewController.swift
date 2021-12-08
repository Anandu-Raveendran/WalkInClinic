//
//  PatientsHomeViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-07.
//

import UIKit
import Firebase
import FirebaseFirestore

class PatientsHomeViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var appointmentTableView: UITableView!
    
    var appointmentList = [AppointmentDao]()
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
        
        appointmentTableView.delegate = self
        appointmentTableView.dataSource = self
        
        let db = Firestore.firestore()
        db.collection("appointment").getDocuments {
            snapshot, error in
            if error != nil{
                print("Get documents returned error")
                return
            } else {
                print("No error in getting doc list")
            }
            
            if let snapshot = snapshot {
                for d in snapshot.documents {
                    print("in document list")
                   
                    self.appointmentList.append(AppointmentDao(id: d.documentID, activeMedication: d["activemedication"] as? String ?? "", consultationFor: d["consultationFor"] as? String ?? "", date: d["date"] as? String ?? "", healthCondition: d["healthCondition"] as? String ?? "", PatientID: d["patient"] as? String ?? "", docName: d["docName"] as? String ?? "", patientName: d["patientName"] as? String ?? "", location:d["location"] as? String ?? ""))
                   
                    self.appointmentTableView.reloadData()
                    }
                }
            }
        let nib = UINib(nibName: "AppointmentTableViewCell", bundle: nil)
        appointmentTableView.register(nib, forCellReuseIdentifier: "appointmentCell")
        }
        
    }
    


extension PatientsHomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appointmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appointmentTableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! AppointmentTableViewCell
        
        cell.title.text = appointmentList[indexPath.row].healthCondition
        cell.doctor.text = appointmentList[indexPath.row].docName
        cell.location.text = appointmentList[indexPath.row].location
        cell.status.text = "Open"
        cell.time.text = appointmentList[indexPath.row].date
        return cell
        
    }
    
    
}
