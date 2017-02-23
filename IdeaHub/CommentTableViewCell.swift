//
//  CommentTableViewCell.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/8/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentCreatorLabel: UILabel!
    
    @IBOutlet weak var commentContentLabel: UILabel!
    
    @IBOutlet weak var commentCreatorImg: RoundPic!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
