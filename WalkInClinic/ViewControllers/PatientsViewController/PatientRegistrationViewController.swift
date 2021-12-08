//
//  UserDetailsViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-05.
//

import UIKit

class PatientRegistrationViewController: UIViewController {

    @IBOutlet weak var healthConditionField: UITextView!
    @IBOutlet weak var medicationField: UITextView!
    @IBOutlet weak var familyDocField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var healthCardField: UITextField!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var dpimage: UIImageView!
    
    @IBAction func submitBtn(_ sender: Any) {
        
        let hcard = healthCardField.text
        let dob = dobField.text
        let weight = weightField.text
        let height = heightField.text
        let familyDoc = familyDocField.text
        let medicationDetails = medicationField.text
        let healthCondition = healthConditionField.text
        
        AppManager.shared.db.collection("users").document(AppManager.shared.loggedInUID!).updateData([
            "hcard":hcard ?? "",
            "dob":dob ?? "",
            "weight":weight ?? "",
            "height":height ?? "",
            "familyDoc":familyDoc ?? "",
            "medication":medicationDetails ?? "",
            "healthCondition":healthCondition ?? ""
        ])
        {
            error in
            
            if(error != nil){
                print("Patient details registration error \(String(describing: error?.localizedDescription))")
            }
        }
          self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
