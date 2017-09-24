//
//  CircleViewImage.swift
//  InstantSocial
//
//  Created by Guner Babursah on 24/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit

class CircleViewImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.width / 2
    }

}
