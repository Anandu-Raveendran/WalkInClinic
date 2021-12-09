//
//  DoctorHomeViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-06.
//

import UIKit
import FirebaseFirestore
import Firebase

class DoctorHomeViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    var doctorDeatils:DoctorDataDao? = nil
    var appointmentList = [AppointmentDao]()
    var selectedAppointment:AppointmentDao? = nil
    var selectedDoc:DoctorDataDao? = nil

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppManager.shared.checkLoggedIn(caller: self)
        
        if let uid = AppManager.shared.loggedInUID {
            
        let docRef = AppManager.shared.db.collection("users").document(uid)
        
        docRef.getDocument{
        (document, error) in
                       
            if let document = document, document.exists {
                
                let data = document.data()
                
                self.doctorDeatils = DoctorDataDao()
                self.doctorDeatils?.name = data?["name"] as? String ?? ""
                self.doctorDeatils?.clinicName = data?["clinicName"] as? String ?? ""
                self.doctorDeatils?.specialisation = data?["specialisation"] as? String ?? ""
                self.doctorDeatils?.clinicAdd = data?["clinicAdd"] as? String ?? ""
                self.doctorDeatils?.college = data?["college"] as? String ?? ""
                self.doctorDeatils?.passYear = data?["passYear"] as? String ?? ""
                self.doctorDeatils?.consultationTime = data?["consultationTime"] as? String ?? ""
                self.doctorDeatils?.days[0] = data?["sunday"] as? Bool ?? false
                self.doctorDeatils?.days[1] = data?["monday"] as? Bool ?? false
                self.doctorDeatils?.days[2] = data?["tuesday"] as? Bool ?? false
                self.doctorDeatils?.days[3] = data?["wednesday"] as? Bool ?? false
                self.doctorDeatils?.days[4] = data?["thursday"] as? Bool ?? false
                self.doctorDeatils?.days[5] = data?["friday"] as? Bool ?? false
                self.doctorDeatils?.days[6] = data?["saturday"] as? Bool ?? false
                
                print("retrieved patient data for \(String(describing: self.doctorDeatils?.clinicName))")
                self.name.text = self.doctorDeatils?.name
                self.location.text = self.doctorDeatils?.clinicAdd
            } else {
                print("Patient Document does not exit for uid \(uid)")
            }
        }
      }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
               
                self.tableView.reloadData()
                }
            }
        }
    let nib = UINib(nibName: "DoctorsAppointmentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DocsAppointmentCell")
    }
}

extension DoctorHomeViewController:UITableViewDelegate, UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    appointmentList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DocsAppointmentCell", for: indexPath) as! DoctorsAppointmentTableViewCell
    
    cell.title.text = appointmentList[indexPath.row].consultationFor
    cell.doctor.text = appointmentList[indexPath.row].docName
    cell.location.text = appointmentList[indexPath.row].location
    if(appointmentList[indexPath.row].status == "Completed"){ cell.status.isHidden = false }
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
