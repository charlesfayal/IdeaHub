//
//  Rounded Image Corners.swift
//  Hatchling
//
//  Created by Steven Graf on 2/1/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class Rounded_Image_Corners: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        clipsToBounds = true
    }

}
