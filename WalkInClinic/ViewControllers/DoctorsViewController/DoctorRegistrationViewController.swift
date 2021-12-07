//
//  DoctorRegistrationViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-01.
//

import UIKit

class DoctorRegistrationViewController: UIViewController {

    var days:[Bool] = [false,false,false,false,false,false,false]

    @IBOutlet weak var dpImage: UIImageView!
    @IBOutlet weak var docName: UILabel!
    @IBOutlet weak var specialisationField: UITextField!
    @IBOutlet weak var clinicNameField: UITextField!
    @IBOutlet weak var clinicAddress: UITextField!
    @IBOutlet weak var collegeAttendedField: UITextField!
    @IBOutlet weak var passoutYearField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBAction func sunday(_ sender: UIButton) {
        sender.changesSelectionAsPrimaryAction = true
        if (days[0] == false) {
            sender.isSelected = true
            sender.tintColor = .green
            days[0] = true
        } else {
            sender.isSelected = false
            sender.tintColor = .white
            days[0] = false
        }
    }
    @IBAction func monday(_ sender: UIButton) {
        sender.changesSelectionAsPrimaryAction = true
        if (days[1] == false) {
            sender.isSelected = true
            sender.tintColor = .green
            days[1] = true
        } else {
            sender.isSelected = false
            sender.tintColor = .white
            days[1] = false
        }
    }
    @IBAction func tuesday(_ sender: UIButton) {
        sender.changesSelectionAsPrimaryAction = true
        if (days[2] == false) {
            sender.isSelected = true
            sender.tintColor = .green
            days[2] = true
        } else {
            sender.isSelected = false
            sender.tintColor = .white
            days[2] = false
        }
    }
    @IBAction func wednesday(_ sender: UIButton) {
        sender.changesSelectionAsPrimaryAction = true
        if (days[3] == false) {
            sender.isSelected = true
            sender.tintColor = .green
            days[3] = true
        } else {
            sender.isSelected = false
            sender.tintColor = .white
            days[3] = false
        }
    }
    @IBAction func thursday(_ sender: UIButton) {
        sender.changesSelectionAsPrimaryAction = true
        if (days[4] == false) {
            sender.isSelected = true
            sender.tintColor = .green
            days[4] = true
        } else {
            sender.isSelected = false
            sender.tintColor = .white
            days[4] = false
        }
    }
    @IBAction func friday(_ sender: UIButton) {
        sender.changesSelectionAsPrimaryAction = true
        if (days[5] == false) {
            sender.isSelected = true
            sender.tintColor = .green
            days[5] = true
        } else {
            sender.isSelected = false
            sender.tintColor = .white
            days[5] = false
        }
    }
    @IBAction func saturday(_ sender: UIButton) {
        sender.changesSelectionAsPrimaryAction = true
        if (days[6] == false) {
            sender.isSelected = true
            sender.tintColor = .green
            days[6] = true
        } else {
            sender.isSelected = false
            sender.tintColor = .white
            days[6] = false
        }
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
           
        let clinicName = clinicNameField.text
        let specialisation = specialisationField.text
        let clinicAdd = clinicAddress.text
        let college = collegeAttendedField.text
        let passYear = passoutYearField.text
        let time = timeTextField.text
        
        AppManager.shared.db.collection("Doctors").document(AppManager.shared.loggedInUID!).setData([
            "clinicName":clinicName ?? "",
            "specialisation":specialisation ?? "",
            "clinicAdd":clinicAdd ?? "",
            "college":college ?? "",
            "passYear": passYear ?? "",
            "consultationTime":time ?? "" ])
        {
            error in
            
            if(error != nil){
                print("Doctor details registration error \(String(describing: error?.localizedDescription))")
            }
        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
            
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
