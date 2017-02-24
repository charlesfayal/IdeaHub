//
//  IdeaTableViewCell.swift
//  IdeaHub
//
//  Created by Charles Fayal on 2/23/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class IdeaTableViewCell: UITableViewCell {

    @IBOutlet weak var usersImgView: UIImageView!
    @IBOutlet weak var usersNameLabel: UILabel!
    
    @IBOutlet weak var ideaLikesLabel: UILabel!
    @IBOutlet weak var ideaDescriptLabel: UILabel!
    @IBOutlet weak var ideaNeedsLabel: UILabel!
    
    @IBOutlet weak var ideaHashtagOutlet: UIButton!
    
    @IBAction func tappedIdeaHashtagBtn(_ sender: Any) {
        print("Tapped Ideas Hash Tag")
    }
    
    @IBAction func tappedLikeBtn(_ sender: Any) {
        print("Liked idea")
    }
    
    @IBAction func tappedDislikeBtn(_ sender: Any) {
        print("Disliked IDea")
    }
    
    @IBAction func tappedCommentBtn(_ sender: Any) {
        print("Tapped Comment")
    }
    
    @IBAction func tappedRequestToJoinBtn(_ sender: Any) {
        print("Tapped Request to join")
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
