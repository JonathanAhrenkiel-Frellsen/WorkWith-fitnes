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
    
    var categories = ["løb", "fitness", "..."]
    var selectedCategory = String()
    
    let datePickerStart = UIDatePicker()
    let datePickerEnd = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        dateFormatStart.dateStyle = .short
        dateFormatStart.timeStyle = .short
        
        startDate.text = dateFormatStart.string(from: datePickerStart.date)
        self.view.endEditing(true)
    }
    
    func donePressedEnd() {
        let dateFormatEnd = DateFormatter()
        dateFormatEnd.dateStyle = .short
        dateFormatEnd.timeStyle = .short
        
        endDate.text = dateFormatEnd.string(from: datePickerEnd.date)
        self.view.endEditing(true)
    }
}
