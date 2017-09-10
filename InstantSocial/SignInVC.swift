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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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

    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("ARTH: Unnable to authenticate with Firebase - \(error)")
            } else {
                print("ARTH: Successsfully authenticated with Firebase")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

