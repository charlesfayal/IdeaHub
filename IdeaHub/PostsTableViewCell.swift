//
//  PostsTableViewCell.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    var post:Post!
    var delegate: UserPostsVC!
    @IBOutlet weak var prodLogo: RoundPic!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodViews: UILabel!
    @IBOutlet weak var prodLikes: UILabel!
    
    @IBAction func tappedCreateUpdateBtn(_ sender: Any) {
        delegate.createUpdate(forPost:post)
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
