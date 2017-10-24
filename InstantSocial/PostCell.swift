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
    
        var post: Post!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
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
    }
}

    


