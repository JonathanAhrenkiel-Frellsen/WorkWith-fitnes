//
//  PartnerDetailViewController.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 25/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import UIKit
import MapKit

class PartnerDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var activeDaysLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    var partnerID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.ds.REF_USER.child(partnerID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let eventDict = snapshot.value as? Dictionary<String, AnyObject> {
                let user = UsersModel(userData: eventDict)
                
                self.nameLabel.text = user.fullname
                self.addressLabel.text = user.address
                
                print(self.addressLabel.text!)
                
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(self.addressLabel.text!) { (placemarks, error) in
                    guard
                        let placemarks = placemarks,
                        let location = placemarks.first?.location
                        else {
                            // handle no location found
                            return
                    }
                    
                    geoCoder.geocodeAddressString(self.addressLabel.text!) { (placemarks, error) in
                        guard
                            let placemarks = placemarks,
                            let location = placemarks.first?.location
                            else {
                                // handle no location found
                                return
                        }
                    let anno = MKPointAnnotation()
                    anno.coordinate = location.coordinate
                    
                    self.map.addAnnotation(anno)
                    }
                }
            }
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var accept: UIButton!
}
