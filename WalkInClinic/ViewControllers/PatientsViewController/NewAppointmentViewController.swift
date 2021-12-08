//
//  NewAppointmentViewController.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-08.
//

import UIKit

class NewAppointmentViewController: UIViewController {

    var selectedDoctor:DoctorDataDao? = nil
    
    @IBOutlet weak var dpimage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var specification: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var consultation: UILabel!
    
    
    @IBOutlet weak var consultationFor: UITextView!
    
    @IBOutlet weak var healthCondition: UITextView!
    
    @IBOutlet weak var activeMedication: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func bookBtn(_ sender: Any) {
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
