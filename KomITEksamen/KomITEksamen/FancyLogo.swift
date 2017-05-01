//
//  FancyLogo.swift
//  LetsGoSocial
//
//  Created by Daniel Jensen on 14/02/2017.
//  Copyright © 2017 SkyCode. All rights reserved.
//

import UIKit

class FancyLogo: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }

}
