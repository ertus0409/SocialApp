//
//  FancyView.swift
//  InstantSocial
//
//  Created by Guner Babursah on 08/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit

class FancyView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.7, height: 0.7)
        layer.cornerRadius = 2.0

    }
    
}
