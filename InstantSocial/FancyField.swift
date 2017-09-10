//
//  FancyField.swift
//  InstantSocial
//
//  Created by Guner Babursah on 08/09/2017.
//  Copyright © 2017 Cem Gulver. All rights reserved.
//

import UIKit

class FancyField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 7)
    }

}
