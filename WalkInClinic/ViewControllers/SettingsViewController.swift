//
//  SettingsViewController.swift
//  BusinessCard
//
//  Created by Nandu on 2021-10-23.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

class SettingsViewController: UIViewController {

    private let storage = Storage.storage().reference()
    private var image:UIImage? = nil
    var callback:(()->())? = nil
    
    @IBOutlet weak var dpImageView: UIImageView!
    @IBOutlet weak var emailIDTextField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var errorField: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    
    
    @IBAction func saveBtn(_ sender: Any) {
        var errorMessage = ""
        
        guard let email = emailIDTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            errorMessage += " Email field is empty"
            errorField.text = errorMessage
            return
        }
        
        if(!RegisterViewController.isEmailValid(email)){
            errorMessage += " Email ID not valid"
        }
        
        guard let name = nameField.text else {
            errorMessage += " Name is empty"
            errorField.text = errorMessage
            return
        }
        
        let phone = Int(phoneNumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0")
        let zip = zipcode.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addr = address.text ?? ""
        
        if(errorMessage.isEmpty || errorMessage == "") {
            
            if let email = emailIDTextField.text{
                if(!email.isEmpty){
                    Auth.auth().currentUser?.updateEmail(to: email, completion: {(error) in
                        if(error != nil){
                            self.errorField.text = "Email update failed"
                            return
                        }
                    })
                }
            }
            
            self.uploadImage()
                
            AppManager.shared.db.collection("users").document(AppManager.shared.loggedInUID!).setData([
                    "name":name, "phone":phone!,
                    "zipcode":zip,
                    "address": addr                ])
                {
                    error in
                    
                    if(error != nil){
                        print("User data create error \(String(describing: error?.localizedDescription))")
                    }
                }
            if let callback = callback {
                callback()
            }
            dismiss(animated: true)
            navigationController?.popViewController(animated: true)
            
        } else{
            errorField.text = errorMessage
        }
    }
    @IBAction func DPImageBtn(_ sender: Any) {
        openImagePicker()
    }
    @IBAction func logoutBtn(_ sender: Any) {
        super.viewDidLoad()

        print("Logout from settings")
        AppManager.shared.logout()
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

        self.hideKeyboardWhenTappedAround()
    }
    
    
    override func viewDidLoad() {
        emailIDTextField.text = FirebaseAuth.Auth.auth().currentUser?.email
        nameField.text = AppManager.shared.userData?.name
        phoneNumberField.text = String(AppManager.shared.userData!.phone)
   
        address.text = AppManager.shared.userData?.address
        zipcode.text = AppManager.shared.userData?.zipcode
        AppManager.shared.getImageFirebase(for_uid: AppManager.shared.loggedInUID ?? "", callback: gotImageCallback )

    }
    
    func gotImageCallback(imageData:Data?){
        if let imageData = imageData {
            self.dpImageView.image = UIImage(data:imageData)
            AppManager.shared.dpImage = UIImage(data:imageData)
        }
    }
}
extension SettingsViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension SettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func openImagePicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.image = image
                
        dpImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(){
        guard let imageData = image?.jpegData(compressionQuality: 0.2) else {
            return
        }
        let imagename = AppManager.shared.loggedInUID

        print("Trying to upload image of size \(imageData.count)")

        let imageRef = storage.child("images/\(String(describing: imagename!)).jpeg")
        let uploadTask = imageRef.putData(imageData, metadata: nil, completion:{ metadata, error in
                
            guard let _ = metadata else {
                print("upload error occured")
                return
            }
            
           
        })
        uploadTask.observe(.failure) {(storageTaskSnapshot) in
            
            if let error = storageTaskSnapshot.error as NSError? {
              switch (StorageErrorCode(rawValue: error.code)!) {
                // Common errors
                case .unauthenticated:
                  print("Error: Unauthenticated; User has not yet logged in ")
                case .unauthorized:
                  print("Error: Unauthorized; User doesn't have permission to access file")
                case .cancelled:
                  print("Error: Cancelled; User cancelled the task")
                case .quotaExceeded    :
                  print("Error: free quota is exceeded; You have to upgrade to Blaze Plan.")
                case .unknown:
                  print("Error: Unknown; Network connection error")

                // Other possible errors
                case .bucketNotFound:
                  print("Error: bucketNotFound")
                case .downloadSizeExceeded:
                  print("Error: downloadSizeExceeded; ")
                case .invalidArgument:
                  print("Error: invalidArgument;")
                case .nonMatchingChecksum:
                  print("Error: nonMatchingChecksum;")
                case .objectNotFound:
                  print("Error: ObjectNotFound; File doesn't exist")
                case .projectNotFound:
                  print("Error: projectNotFound;")
                case .retryLimitExceeded:
                  print("Error: retryLimitExceeded;")
               default:
                  print("Error: some other error occured")
              }
        }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
