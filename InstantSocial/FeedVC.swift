//
//  FeedVC.swift
//  InstantSocial
//
//  Created by Guner Babursah on 13/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    @IBAction func SignOutBtnTapped(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("ARTH: ID removed from keychain: \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
        
    }
    

   
}
