//
//  DataService.swift
//  InstantSocial
//
//  Created by Guner Babursah on 01/10/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB References:
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("user")
    //Storage References:
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_POST_IMAGES: StorageReference {
        return _REF_POST_IMAGES
    }
    
    
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
//        REF_USERS.child(uid).chil
//        
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User(username: username)
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
