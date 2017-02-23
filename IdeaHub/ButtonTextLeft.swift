//
//  ButtonTextLeft.swift
//  Hatchling
//
//  Created by Steven Graf on 1/18/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class ButtonTextLeft: UIButton {

    override func awakeFromNib() {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
    }

}
