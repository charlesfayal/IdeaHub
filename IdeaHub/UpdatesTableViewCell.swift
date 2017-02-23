//
//  UpdatesTableViewCell.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/3/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var prodLogo: RoundPic!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var updateDescript: UILabel!
    @IBOutlet weak var updateLink: UIButton!
    
    var update:Update!
    
    @IBAction func tappedLinkBtn(_ sender: Any) {
        print("Chuck: Tapped update link button")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
