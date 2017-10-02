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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //IBOUTLETS:
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print(snapshot.value!)
        })

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }

    
    //SIGN OUT BTN (KeychainnWrapper):
    @IBAction func SignOutBtnTapped(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ARTH: ID removed from keychain: \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

   
}
