//
//  PostCell.swift
//  InstantSocial
//
//  Created by Guner Babursah on 27/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage

class PostCell: UITableViewCell {
    
    //IBOUTLETS:
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    //VARIABLES:
    var post: Post!
    var likesRef: DatabaseReference!
    var userRef: DatabaseReference!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
    }
    
    
    //CONFIGURE CELL
    func configureCell(post: Post, img: UIImage? = nil) {
        
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
        
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            print("ARTH!")
            self.postImage.image = img
        } else {
            print("ARTH: \(post.imageUrl)")
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("ARTH: Unable yo download from Firebase Storage.")
                } else {
                    print("ARTH: Successfullt downnloaded from Firebase Storage.")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
        
        //USERNAMW:
//        userRef = DataService.ds.REF_USER_CURRENT.child("username")
//        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            self.usernameLbl.text = snapshot.value as! String
//        })
        
        //LIKE OBSERVER:
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "empty-heart")
            } else {
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })
    }
    
    //LIKE TAPPED:
    func likeTapped(sender: UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })
    }
}

    


