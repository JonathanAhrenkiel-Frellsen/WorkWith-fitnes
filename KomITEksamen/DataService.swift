//
//  DataService.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 24/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("Users")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USER: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USER.child(uid).updateChildValues(userData)
    }
    
    // før hed funkrionen createFirebaseDBUserList createFirbaseDBUserList, ved ikke om det øgr en forekeld
    func createFirebaseDBUserList(uid: String, userData: Dictionary<String, AnyObject>) {
        REF_USER.child(uid).updateChildValues(userData)
    }
    
    func createFirebaseDBUSerList(uid: String, userData: Dictionary<String, AnyObject>) {
        REF_BASE.child(uid).updateChildValues(userData)
    }
    
    func createFirbaseDBUSERList(uid: String, userData: Dictionary<String, AnyObject>) {
        REF_BASE.child(uid).updateChildValues(userData)
    }
}
