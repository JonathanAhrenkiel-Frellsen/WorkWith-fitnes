//
//  CreateEventViewController.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 23/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import UIKit
import Firebase

class CreateEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var man: UIButton!
    @IBOutlet weak var tir: UIButton!
    @IBOutlet weak var ond: UIButton!
    @IBOutlet weak var tor: UIButton!
    @IBOutlet weak var fre: UIButton!
    @IBOutlet weak var lør: UIButton!
    @IBOutlet weak var søn: UIButton!
    
    var manOn = -1
    var tirOn = -1
    var ondOn = -1
    var torOn = -1
    var freOn = -1
    var lørOn = -1
    var sønOn = -1
    
    var fullnameP = String()
    var birthdateP = String()
    var addressP = String()
    var emailP = String()
    
    var categories = ["løb", "fitness", "..."]
    var selectedCategory = String()
    
    let datePickerStart = UIDatePicker()
    let datePickerEnd = UIDatePicker()
    
    var ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("TEST: \(fullnameP)")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        createDatePickerStart()
        createDatePickerEnd()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields to resign the first responder status.
        view.endEditing(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createEvent(_ sender: Any) {
        
        createEvent(category: selectedCategory, startDate: startDate.text!, endDate: endDate.text!, addressWorkOut: address.text!, man: manOn, tir: tirOn, ond: ondOn, tor: torOn, fre: freOn, lør: lørOn, søn: sønOn, fullname: fullnameP, birthdate: birthdateP, address: addressP, email: emailP)
    }
    
//    func registerUser () {
//        if let fullName = fullNameTextField.text, let email = EmailTextField.text, let pwd = passwordTextField.text {
//            FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: {(user, error) in
//                if error != nil {
//                    print("Unable to authenticate with Firebase using email")
//                } else {
//                    print("Succesfully authenticated with Firebase using email")
//                    
//                    if let user = user {
//                        let eventData = ["event": user.providerID]
//                        self.createDBChild(id: user.uid, userData: eventData)
//                        let userData = ["provider": user.providerID]
//                        self.completeSignIn(id: user.uid, userData: userData)
//                        let fullNameData = ["fullname": fullName]
//                        self.createDBChild(id: user.uid, userData: fullNameData)
//                        let emailData = ["email": email]
//                        self.createDBChild(id: user.uid, userData: emailData)
//                        let address = ["address": self.addressTextField.text]
//                        self.createDBChild(id: user.uid, userData: address as! Dictionary<String, String>)
//                        self.createDBChild(id: user.uid, userData: ["birthdate": String(describing: self.birthPickerStart.date)])
//                        
//                        self.performSegue(withIdentifier: "completeRegi", sender: nil)
//                    }
//                }
//            })
//        } else {
//            print("Full name field not filled!")
//        }
//    }
    
    func createEvent (category: String, startDate: String, endDate: String, addressWorkOut: String, man: Int, tir: Int, ond: Int, tor: Int, fre: Int, lør: Int, søn: Int, fullname: String, birthdate: String, address: String, email: String) {
        let category = category
        let startDate = startDate
        let endDate = endDate
        let addressWorkOut = addressWorkOut
        let fullname = fullname
        let birthdate = birthdate
        let address = address
        let email = email
        
        var manString = String()
        var tirString = String()
        var ondString = String()
        var torString = String()
        var freString = String()
        var lørString = String()
        var sønString = String()
        var daysAmount = Int()
        var activeDays = String()
        
        print("category: \(category), startDate: \(startDate), endDate: \(endDate), activeDays: \(activeDays), addressWorkOut: \(addressWorkOut), fullname: \(fullname), birthdate: \(birthdate), address: \(address), email: \(email)")
        
        if (man > 0) {
            manString = "mandag"
            daysAmount += 1
            
            activeDays.append(manString + ", ")
        }
        
        if (tir > 0) {
            tirString = "tirsdag"
            daysAmount += 1
            
            activeDays.append(tirString + ", ")
        }
        
        if (ond > 0) {
            ondString = "ondsdag"
            daysAmount += 1
            
            activeDays.append(ondString + ", ")
        }
        
        if (tor > 0) {
            torString = "torsdag"
            daysAmount += 1
            
            activeDays.append(torString + ", ")
        }
        
        if (fre > 0) {
            freString = "fredag"
            daysAmount += 1
            
            activeDays.append(freString + ", ")
        }
        if (lør > 0) {
            lørString = "lørdag"
            daysAmount += 1
            
            activeDays.append(lørString + ", ")
        }
        if (søn > 0) {
            sønString = "søndag"
            daysAmount += 1
            
            activeDays.append(sønString)
        }
        
        let event: [String: AnyObject] = ["category": category as AnyObject,
                                          "startDate": startDate as AnyObject,
                                          "endDate": endDate as AnyObject,
                                          "activeDays": activeDays as AnyObject,
                                          "addressWorkOut": addressWorkOut as AnyObject,
                                          "fullname": fullname as AnyObject,
                                          "birthdate": birthdate as AnyObject,
                                          "address": address as AnyObject,
                                          "email": email as AnyObject]
        
        let ref = FIRDatabase.database().reference()
        
        if (category.isEmpty || startDate.isEmpty || endDate.isEmpty || address.isEmpty) {
            errorHandelingCreateEvent()
        } else {
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("Users").child(userID!).setValue(event)
            
            self.performSegue(withIdentifier: "completeRegi", sender: nil)
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
    func createDatePickerStart() {
        let toolbarStart = UIToolbar()
        toolbarStart.sizeToFit()
        
        let doneButtonStart = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedStart))
        toolbarStart.setItems([doneButtonStart], animated: false)
        
        startDate.inputAccessoryView = toolbarStart
        
        startDate.inputView = datePickerStart
    }
    
    func createDatePickerEnd () {
        let toolbarEnd = UIToolbar()
        toolbarEnd.sizeToFit()
        
        let doneButtonEnd = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedEnd))
        toolbarEnd.setItems([doneButtonEnd], animated: false)
        
        endDate.inputAccessoryView = toolbarEnd
        
        endDate.inputView = datePickerEnd
    }
    
    func donePressedStart() {
        let dateFormatStart = DateFormatter()
        dateFormatStart.dateStyle = .none
        dateFormatStart.timeStyle = .short
        
        startDate.text = dateFormatStart.string(from: datePickerStart.date)
        self.view.endEditing(true)
    }
    
    func donePressedEnd() {
        let dateFormatEnd = DateFormatter()
        dateFormatEnd.dateStyle = .none
        dateFormatEnd.timeStyle = .short
        
        endDate.text = dateFormatEnd.string(from: datePickerEnd.date)
        self.view.endEditing(true)
    }
    
    func errorHandelingCreateEvent() {
        let alertController = UIAlertController(title: "can't create event", message: "one of the parametors is not assignt", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func man(_ sender: Any) {
        if (manOn < 0) {
            man.backgroundColor = UIColor(colorLiteralRed: 69/255, green: 167/255, blue: 69/255, alpha: 100)
            
            manOn *= -1
        } else {
            man.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 128/255, blue: 255/255, alpha: 100)
            
            manOn *= -1
        }
    }
    
    @IBAction func tir(_ sender: Any) {
        if (tirOn < 0) {
            tir.backgroundColor = UIColor(colorLiteralRed: 69/255, green: 167/255, blue: 69/255, alpha: 100)
            
            tirOn *= -1
        } else {
            tir.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 128/255, blue: 255/255, alpha: 100)
            
            tirOn *= -1
        }
    }
    
    @IBAction func ond(_ sender: Any) {
        if (ondOn < 0) {
            ond.backgroundColor = UIColor(colorLiteralRed: 69/255, green: 167/255, blue: 69/255, alpha: 100)
            
            ondOn *= -1
        } else {
            ond.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 128/255, blue: 255/255, alpha: 100)
            
            ondOn *= -1
        }
    }

    @IBAction func tor(_ sender: Any) {
        if (torOn < 0) {
            tor.backgroundColor = UIColor(colorLiteralRed: 69/255, green: 167/255, blue: 69/255, alpha: 100)
            
            torOn *= -1
        } else {
            tor.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 128/255, blue: 255/255, alpha: 100)
            
            torOn *= -1
        }
    }
    
    @IBAction func fre(_ sender: Any) {
        if (freOn < 0) {
            fre.backgroundColor = UIColor(colorLiteralRed: 69/255, green: 167/255, blue: 69/255, alpha: 100)
            
            freOn *= -1
        } else {
            fre.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 128/255, blue: 255/255, alpha: 100)
            
            freOn *= -1
        }
    }
    
    @IBAction func lør(_ sender: Any) {
        if (lørOn < 0) {
            lør.backgroundColor = UIColor(colorLiteralRed: 69/255, green: 167/255, blue: 69/255, alpha: 100)
            
            lørOn *= -1
        } else {
            lør.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 128/255, blue: 255/255, alpha: 100)
            
            lørOn *= -1
        }
    }
    
    @IBAction func søn(_ sender: Any) {
        if (sønOn < 0) {
            søn.backgroundColor = UIColor(colorLiteralRed: 69/255, green: 167/255, blue: 69/255, alpha: 100)
            
            sønOn *= -1
        } else {
            søn.backgroundColor = UIColor(colorLiteralRed: 0/255, green: 128/255, blue: 255/255, alpha: 100)
            
            sønOn *= -1
        }
    }
}
