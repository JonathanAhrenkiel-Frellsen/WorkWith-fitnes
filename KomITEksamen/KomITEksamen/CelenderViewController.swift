//
//  CelenderViewController.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 26/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import UIKit
import EventKit
import FirebaseAuth
import Firebase

class CelenderViewController: UIViewController {
    var eventName = String()
    var eventStartDate = String()
    var eventEndDate = String()
    var activeDays = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
//        DataService.ds.REF_USER.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let eventDict = snapshot.value as? Dictionary<String, AnyObject> {
//                let user = UsersModel(userData: eventDict)
//                
//                self.eventName = user.category
//                
//                // reformats the string date stored in firebase and formats it as Date
//                // alternativly i could have stored secundsSince 1970 in firebase af int, and format from there, but i'm lazy xd, this would also solve time zone problems
////                let dateFormatter = DateFormatter()
////                dateFormatter.dateFormat = "yyyy-MM-dd"
////                
////                let dateStart = dateFormatter.date(from: user.startDate)
////                let dateEnd = dateFormatter.date(from: user.startDate)
//                
//                self.eventStartDate = user.startDate
//                self.eventEndDate = user.endDate
//                
//                self.activeDays = user.acriveDays.components(separatedBy: [","])
//                
//                for day in self.activeDays {
//                    let date = Date()
//                    let formatter = DateFormatter()
//                    
//                    formatter.dateFormat = "dd.MM.yyyy"
//                    
//                    let currentDate = formatter.string(from: date)
//                    
//                    //self.getDayOfWeek(today: currentDate)
//                    
//                    print(currentDate)
//                }
//            }
//        })
        
        func getDayOfWeek(today:String)->Int {
            
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let todayDate = formatter.date(from: today)!
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let myComponents = myCalendar.components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday
            return weekDay!
        }

//        let eventStore = EKEventStore();
//        
//        if let calendarForEvent = eventStore.calendarWithIdentifier(self.calendar.calendarIdentifier) {
//            let newEvent = EKEvent(eventStore: eventStore)
//            
//            newEvent.calendar = calendarForEvent
//            newEvent.title = "Some Event Name"
//            newEvent.startDate = eventStartDate
//            newEvent.endDate = eventEndDate
//        }
        
        //let event = EKEvent(eventStore: eventStore)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
