//
//  RoundPic.swift
//  Hatchling
//
//  Created by Steven Graf on 1/14/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class RoundPic: UIImageView {
    
    var measurement: CGFloat!
    
    func radius() {
        if self.frame.height < self.frame.width {
            measurement = self.frame.height
        } else {
            measurement = self.frame.width
        }
    }
    
    override func awakeFromNib() {
        self.radius()
        self.layer.cornerRadius = measurement / 2
        self.clipsToBounds = true
    }


}

