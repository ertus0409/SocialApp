//
//  CreateUserVC.swift
//  InstantSocial
//
//  Created by Guner Babursah on 12/11/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FirebaseAuth

class CreateUserVC: UIViewController {
    
    //IBOUTLETS:
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var usernameField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    @IBOutlet weak var errorLbl: UILabel!
    
    //VARIABLES:
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func createUserBtnTapped(_ sender: Any) {
        
        guard let user = usernameField.text, user != "" else {
            errorLbl.text = "Username must be entered."
            errorLbl.textColor = UIColor.red
            return
        }
        guard let password = passwordField.text, password != "" else {
            errorLbl.text = "Password must be entered."
            errorLbl.textColor = UIColor.red
            return
        }
        guard let email = emailField.text, email != "" else {
            errorLbl.text = "Email must be entered."
            errorLbl.textColor = UIColor.red
            return
        }
        
        Auth.auth().fetchProviders(forEmail: emailField.text!) { (emails, error) in
            if emails == nil {
                print("ARTH: Email not in use.")
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print("ARTH: Unable to authenticate with Firebase usinng email.")
                    } else {
                        print("ARTH: Successfully authenticated with Firebase with email.")
                        
                        if let user = user {
                            let userData = ["provider": user.providerID]
                            self.completeSignin(id: user.uid, userData: userData)
                            
                        }
                    }
                })
            } else {
                self.errorLbl.text = "Email you entered is in use. Use a different email adress."
            }
        }
    }
    
    //KEYCHAIN WRAPPER USER UID SAVE
    func completeSignin(id: String, userData: Dictionary<String, String>){
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        DataService.ds.REF_USER_CURRENT.child("username").setValue(usernameField.text)
        print("ARTH: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "showFeed", sender: nil)
    }
    
    
    
    
    
    
    
    
    

}
