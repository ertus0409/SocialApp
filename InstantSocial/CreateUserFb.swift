//
//  CreateUserFb.swift
//  InstantSocial
//
//  Created by Guner Babursah on 25/11/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit

class CreateUserFb: UIViewController {
    
    
    //IBOUTLETS:
    @IBOutlet weak var usernameField: FancyField!
    @IBOutlet weak var label: UILabel!
    
    //VARIABLES:
    var userKey: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func continueTapped(_ sender: Any) {
        
        if usernameField.text == nil || usernameField.text == "" {
            label.text = "A username must be entered."
            label.textColor = UIColor.red
        } else {
            DataService.ds.REF_USERS.child(userKey).child("username").setValue(usernameField.text)
            performSegue(withIdentifier: "fbFeed", sender: self)
        }
        
        
    }
    

}
