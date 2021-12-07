//
//  HomeViewController.swift
//  BusinessCard
//
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class HomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        AppManager.shared.checkLoggedIn(caller: self)
        print("Home view will Appear")
        
        if let uid = AppManager.shared.loggedInUID {
            AppManager.shared.getUserDataFireBase(for: uid, callback: getUserDataCallback)
        }
        super.viewWillAppear(true)
    }
        
    func getUserDataCallback(contact:UserDataDao){
        
        AppManager.shared.userData = contact
        print("retrieved dict for \(contact.role) \(String(describing: AppManager.shared.userData?.name))")
    
        if (contact.role == "doctor") {
            performSegue(withIdentifier: "doctorHomeSegue", sender: self)
        } else if (contact.role == "patient") {
            performSegue(withIdentifier: "patientHomeSegue", sender: self)
        } else {
            print("Role not identified")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSettings"){
            let dest = segue.destination as! SettingsViewController
            dest.callback = dataUpdateDone
        }
    }
    
    func dataUpdateDone(){
        print("dataUpdateDone called")
        if let uid = AppManager.shared.loggedInUID {
            AppManager.shared.getUserDataFireBase(for: uid, callback: getUserDataCallback)
        }
    }
}


