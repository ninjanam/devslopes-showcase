//
//  MaterialView.swift
//  devslopes-showcase
//
//  Created by Nam-Anh Vu on 20/10/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    // called when the view is loaded from the storyboard
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8 // how much you want it to blur
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    

}
