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
    var selectedAppointment:AppointmentDao? = nil
    var selectedDoc:DoctorDataDao? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppManager.shared.checkLoggedIn(caller: self)
        
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
                   
                    self.appointmentList.append(AppointmentDao(id: d.documentID, activeMedication: d["activemedication"] as? String ?? "", consultationFor: d["consultationFor"] as? String ?? "", date: d["date"] as? String ?? "", healthCondition: d["healthCondition"] as? String ?? "", PatientID: d["patient"] as? String ?? "", docName: d["docName"] as? String ?? "", patientName: d["patientName"] as? String ?? "", location:d["location"] as? String ?? "", docID: d["docID"] as? String ?? "", status: d["status"] as? String ?? ""))
                   
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
        
        cell.title.text = appointmentList[indexPath.row].consultationFor
        cell.doctor.text = appointmentList[indexPath.row].docName
        cell.location.text = appointmentList[indexPath.row].location
        cell.status.text = appointmentList[indexPath.row].status
        cell.time.text = appointmentList[indexPath.row].date
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAppointment = appointmentList[indexPath.row]
        
        if let docID = selectedAppointment?.docID {
        let docRef = AppManager.shared.db.collection("users").document(docID)
        
        docRef.getDocument{
        (document, error) in
                       
            if let document = document, document.exists {
                
                if let d = document.data() {
                
                self.selectedDoc = DoctorDataDao(
                         name: d["name"] as? String ?? "", phone: d["phone"] as? Int64 ?? 0, address: d["address"] as? String ?? "", zipcode: d["zipcode"] as? String ?? "" , role: d["role"] as? String ?? "", email: d["email"] as? String ?? "", uid: docID,
                                             clinicName: d["clinicName"] as? String ?? "", specialisation: d["specialisation"] as? String ?? "", clinicAdd: d["clinicAdd"] as? String ?? "", college: d["college"] as? String ?? "", passYear: d["passYear"] as? String ?? "", consultationTime: d["consultationTime"] as? String ?? "",
                                                 days: [
                                                     d["sunday"] as? Bool ?? false,
                                                     d["monday"] as? Bool ?? false,
                                                     d["tuesday"] as? Bool ?? false,
                                                     d["wednesday"] as? Bool ?? false,
                                                     d["thursday"] as? Bool ?? false,
                                                     d["friday"] as? Bool ?? false,
                                                     d["saturday"] as? Bool ?? false])

                    self.performSegue(withIdentifier: "toAppointmentDetails", sender: nil)

                print("retrieved doc data for \(String(describing: self.patientDetails?.hcard))")
            } else {
                print("doc Document does not exit for uid \(docID)")
            }
        }
        }
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAppointmentDetails" {
            let dest = segue.destination as! NewAppointmentViewController
            dest.selectedAppointment = selectedAppointment
            dest.selectedDoctor = selectedDoc
        }
    }
    
}
