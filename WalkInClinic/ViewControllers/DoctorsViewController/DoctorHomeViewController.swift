//
//  DoctorHomeViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-06.
//

import UIKit

class DoctorHomeViewController: UIViewController {

    var doctorDeatils:DoctorDataDao? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let uid = AppManager.shared.loggedInUID {
            
        let docRef = AppManager.shared.db.collection("users").document(uid)
        
        docRef.getDocument{
        (document, error) in
                       
            if let document = document, document.exists {
                
                let data = document.data()
                
                self.doctorDeatils = DoctorDataDao()
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
                
            } else {
                print("Patient Document does not exit for uid \(uid)")
            }
        }
      }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
