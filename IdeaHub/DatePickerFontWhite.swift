//
//  DatePickerFontWhite.swift
//  Hatchling
//
//  Created by Steven Graf on 1/17/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class DatePickerFontWhite: UIDatePicker {

    override func awakeFromNib() {
        self.setValue(UIColor.white, forKey: "textColor")
    }

}
