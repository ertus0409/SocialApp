//
//  CircleViewImage.swift
//  InstantSocial
//
//  Created by Guner Babursah on 24/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit

class CircleViewImage: UIImageView {
    
   

    override func layoutSubviews() {
        
        layer.cornerRadius = self.frame.width / 2
        
    }

}
