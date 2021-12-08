//
//  DoctorsListViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-08.
//

import UIKit
import Firebase
import FirebaseFirestore

class DoctorsListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var doctorsList = [DoctorDataDao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let db = Firestore.firestore()
        db.collection("users").getDocuments {
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
                    let role = d["role"] as? String ?? ""
                    if( role == "doctor") {
                        print("role is doc")
                        self.doctorsList.append( DoctorDataDao(
                            name: d["name"] as? String ?? "", phone: d["phone"] as? Int64 ?? 0, address: d["address"] as? String ?? "", zipcode: d["zipcode"] as? String ?? "" , role: d["role"] as? String ?? "", email: d["email"] as? String ?? "", uid: d.documentID,
                                                clinicName: d["clinicName"] as? String ?? "", specialisation: d["specialisation"] as? String ?? "", clinicAdd: d["clinicAdd"] as? String ?? "", college: d["college"] as? String ?? "", passYear: d["passYear"] as? String ?? "", consultationTime: d["consultationTime"] as? String ?? "",
days: [
    d["sunday"] as? Bool ?? false,
                                            d["monday"] as? Bool ?? false,
                                                       d["tuesday"] as? Bool ?? false,
                                                       d["wednesday"] as? Bool ?? false,
                                                       d["thursday"] as? Bool ?? false,
                                                       d["friday"] as? Bool ?? false,
                                                       d["saturday"] as? Bool ?? false]))
                        
                       
                            
                    }
                }
            }
        }
        
        
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "DoctorsListTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "DoctorsListTableViewCell")

    }
}

extension DoctorsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("returned \(doctorsList.count) as the doctors list count")
        return doctorsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorsListTableViewCell", for: indexPath) as! DoctorsListTableViewCell
        cell.name.text = doctorsList[indexPath.row].name
        return cell
    }
    
    
}
