//
//  UsersModel.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 24/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import Foundation

class UsersModel: NSObject {
    private var _fullname: String!
    private var _email: String!
    private var _birthDate: String!
    private var _address: String!
    private var _tag: String!
    private var _bio: String!
    
    var fullname: String {
        return _fullname
    }
    
    var email: String {
        return _email
    }
    
    var birthDate: String {
        return _birthDate
    }
    
    var address: String {
        return _address
    }
    
    var tag: String {
        return _tag
    }
    
    var bio: String {
        return _bio
    }
    
    init(fullname: String, email: String, birthDate: String, address: String, tag: String, bio: String) {
        self._fullname = fullname
        self._email = email
        self._birthDate = birthDate
        self._address = address
        self._tag = tag
        self._bio = bio
    }
    
    init(userData : Dictionary<String, AnyObject>) {
        if let fullname = userData["fullname"] as? String {
            self._fullname = fullname
        }
        
        if let email = userData["email"] as? String {
            self._email = email
        }
        
        if let birthDate = userData["birthdate"] as? String {
            self._birthDate = birthDate
        }
        
        if let address = userData["address"] as? String {
            self._address = address
        }
        
        if let tag = userData["tag"] as? String {
            self._tag = tag
        }
        
        if let bio = userData["bio"] as? String {
            self._bio = bio
        }
    }
}
