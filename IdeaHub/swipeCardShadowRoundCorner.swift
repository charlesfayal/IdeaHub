//
//  swipeCardShadowRoundCorner.swift
//  Hatchling
//
//  Created by Steven Graf on 1/14/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class swipeCardShadowRoundCorner: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 16.0
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
