//
//  LogInViewController.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 23/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogIn(_ sender: Any) {
        performSegue(withIdentifier: "LogIn", sender: nil)
    }
    
    @IBAction func register(_ sender: Any) {
    }
}
