//
//  RoundButton.swift
//  InstantSocial
//
//  Created by Guner Babursah on 08/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        layer.cornerRadius = 5.0   (NOT RECOMMENDED)
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width/2
        //(RECOMMENDED)
        //Because we cann use the frame object it is better to set the corners with layoutSubviews and calculate instead of giving a random number.
    }
}
