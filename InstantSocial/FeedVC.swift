//
//  FeedVC.swift
//  InstantSocial
//
//  Created by Guner Babursah on 13/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit
import Foundation
import SwiftKeychainWrapper
import Firebase
import FirebaseStorageUI

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //IBOUTLETS:
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: CircleViewImage!
    @IBOutlet weak var captionField: FancyField!
    
    //VARIABLES:
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.observe()
        
        
    }
    
    //TABLEVIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCel") as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
            } else {
                cell.configureCell(post: post)
            }
            return cell
        } else {
            return PostCell()
        }
        
    }
    
    
    //IMAGEPICKER:
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
            imageSelected = true
        } else {
            print("ARTH: A valid image wasn't selected.")
            imageSelected = false
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addImageTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //OBSERVER:
    func observe() {
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            self.posts = []
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })

    }

    //POST BUTTON:
    @IBAction func PostBtnTapped(_ sender: Any) {
        
        guard let caption = captionField.text, caption != "" else {
            print("ARTH: Caption must be entered.")
            captionField.placeholder = "Add an image and a caption."
            return
        }
        guard let image = imageAdd.image, imageSelected == true else {
            print("ARTH: An image must be selected")
            return
        }
        //Compressing the image in order to fasten the download process:
        if let imgData = UIImageJPEGRepresentation(image, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            //Downloading the image to
            DataService.ds.REF_POST_IMAGES.child(imgUid).putData(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("ARTH: Unable to upload image to Fİrebase Storage")
                } else {
                    print("ARTH: Successfully uploaded the image to Firebase Storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.postToFirebase(imgUrl: url)
                    }
                }
            }
                
        }
        captionField.endEditing(true)
    }
    
    //FUNCTION TO MAKE THE POST:
    func postToFirebase(imgUrl: String) {
        let post: Dictionary<String, AnyObject> = [
            "caption": captionField.text as AnyObject  ,
            "imageUrl": imgUrl as AnyObject,
            "likes": 0 as AnyObject,
//            "user": //WİLL BE ADDED
        ]
        let _ = DataService.ds.REF_POSTS.childByAutoId().setValue(post)
        
        var ref: DatabaseReference!
        
        
        
        captionField.text = ""
        imageSelected = false
        imageAdd.image = UIImage(named: "add-image")
    }
    
    //SIGN OUT BTN (KeychainnWrapper):
    @IBAction func SignOutBtnTapped(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ARTH: ID removed from keychain: \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

   
}
