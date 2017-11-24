//
//  SignInVC.swift
//  InstantSocial
//
//  Created by Guner Babursah on 05/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {
    var i = 1
    //IBOutlets:
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var centerPopup: NSLayoutConstraint!
    @IBOutlet weak var popupUsername: FancyField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if KeychainWrapper.standard.string(forKey: KEY_UID) != nil {
            print("ARTH: UID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    
    
    
    //FIREBASE EMAIL AUTHENTICATION FOR CREATING USER:
    @IBAction func SigninTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("AUTH: Email user authenticated with Firebase.")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignin(id: user.uid, userData: userData)
                        self.performSegue(withIdentifier: "goToFeed", sender: nil)
                        
                    }
                } else {
                    //New User
                    self.errorLbl.text = "Invalid user information. Try again or create an accout."
                    self.errorLbl.textColor = UIColor.red
                }
            })
        }
    }
    
    
    
    
    
    //FACEBOOK SIGNIN:
    @IBAction func FBSignInTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ARTH: Unable to authenticate with Facebook. - \(error)")
            } else if result?.isCancelled == true {
                print("ARTH: User cancelled Facebook authentication")
            } else {
                print("ARTH: Successfully authenticated with Facebook.")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
//                self.fetchUserProfile()
//                self.performSegue(withIdentifier: "FBSignInUsername", sender: nil)
            }
        }
    }
    
    
    
    
    
    
    //FIREBASE AUTH FOR FACEBOOK:
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("ARTH: Unnable to authenticate with Firebase - \(error)")
            } else {
                print("ARTH: Successsfully authenticated with Firebase")
                if let user = user {
                    let userData = ["proivder": credential.provider]
                    print("DATA:\(userData.description)")
                    self.completeSignin(id: user.uid, userData: userData)
                }
                
            }
        }
    }
    
    
    
    
    
    
    //KEYCHAIN WRAPPER USER UID SAVE
    func completeSignin(id: String, userData: Dictionary<String, String>){
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ARTH: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
    @IBAction func continueUsernameTapped(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
}

