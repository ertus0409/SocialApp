//
//  PostCell.swift
//  InstantSocial
//
//  Created by Guner Babursah on 27/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    //IBOUTLETS:
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
