//
//  TableViewController.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 23/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {    
    var nameList = [String]()
    var categoriesList = [String]()
    var addressList = [String]()
    
    var userIDList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.ds.REF_USER.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let eventDict = snap.value as? Dictionary<String, AnyObject> {
                        let user = UsersModel(userData: eventDict)
                        
                        self.nameList.append(user.fullname)
                        self.categoriesList.append(user.tag)
                        self.addressList.append(user.address)
                        
                        self.userIDList.append(snap.key)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return nameList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FindPartnerTableViewCell
        
        cell.nameLabel?.text = nameList[indexPath.row]
        cell.categoryLabel?.text = categoriesList[indexPath.row]
        cell.addressLabel?.text = addressList[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "partnerDetail" {
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let DestViewController : PartnerDetailViewController = segue.destination as! PartnerDetailViewController
            
            DestViewController.partnerID = userIDList[indexPath.row]
        }
    }
}
