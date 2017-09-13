//
//  SignInVC.swift
//  InstantSocial
//
//  Created by Guner Babursah on 05/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    //IBOutlets:
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID) != nil {
            print("ARTH: UID found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //FIREBASE EMAIL AUTHENTICATION FOR CREATING USER:
    @IBAction func SigninTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("AUTH: Email user authenticated with Firebase.")
                } else {
                    
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("ARTH: Unable to authenticate with Firebase usinng email.")
                        } else {
                            print("ARTH: Successfully authenticated with Firebase with email.")
                            
                            if let user = user {
                                self.completeSignin(id: user.uid)
//                                print(KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID))
                            }
                        }
                    })
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
                    self.completeSignin(id: user.uid)
                }
                
            }
        }
    }
    
    //KEYCHAIN WRAPPER USER UID SAVE
    func completeSignin(id: String){
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ARTH: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

