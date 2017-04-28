//
//  RegisterViewController.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 23/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class RegisterViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var bioTextBox: UITextView!
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    
    var fullname = String()
    var birthDate = String()
    var address = String()
    var email = String()
    
    let birthPickerStart = UIDatePicker()

    var strDate = String()
    
    var friendsList = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbarStart = UIToolbar()
        toolbarStart.sizeToFit()
        
        let doneButtonStart = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbarStart.setItems([doneButtonStart], animated: false)
        
        birthTextField.inputAccessoryView = toolbarStart
        
        birthTextField.inputView = birthPickerStart
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        //let strDate = dateFormatter.string(from: ageDatePicker.date)
    }
    
    func donePressed() {
        let dateFormatStart = DateFormatter()
        dateFormatStart.dateStyle = .short
        dateFormatStart.timeStyle = .none
        
        birthTextField.text = dateFormatStart.string(from: birthPickerStart.date)
        self.view.endEditing(true)
    }
    
    @IBAction func register(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: EmailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            if error != nil {
                self.errorHandelingRegister()
                
                print(error ?? "")
            } else {
                self.createUserData()
                
                self.performSegue(withIdentifier: "completeRegi", sender: nil)
            }
        })
    }
    
    func errorHandelingRegister() {
        let alertController = UIAlertController(title: "This acount exist", message: "An user with this mail has already signed up", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func createUserData () {
        let user : [String : AnyObject] = ["fullname": self.fullNameTextField.text as AnyObject,
                                           "bithDate": self.birthTextField.text as AnyObject,
                                           "address": self.addressTextField.text as AnyObject,
                                           "bio": self.bioTextBox.text as AnyObject,
                                           "email": self.EmailTextField.text as AnyObject,
                                           "tag": self.tagTextField.text as AnyObject]
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("Users").childByAutoId().setValue(user)
    }
    
    func createDBChild(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        print("Succesfully created a child")
        
        let user : [String : AnyObject] = ["fullname": fullNameTextField.text as AnyObject,
                                           "bithDate": birthTextField.text as AnyObject,
                                           "address": addressTextField.text as AnyObject,
                                           "bio": bioTextBox.text as AnyObject,
                                           "email": EmailTextField.text as AnyObject,
                                           "tag": tagTextField.text as AnyObject]
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("Users").childByAutoId().setValue(user)
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data saved to the keychain \(keychainResult)")
    }
}
