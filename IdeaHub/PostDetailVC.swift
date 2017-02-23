//
//  PostDetailViewVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class PostDetailVC: UIViewController {

    var post:Post!
    
    @IBOutlet weak var postImg: UIImageView!

    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postLogo: RoundPic!
    @IBOutlet weak var postShortDescript: UILabel!
    @IBOutlet weak var postStage: UILabel!
    @IBOutlet weak var postLongDescript: UILabel!
    @IBOutlet weak var postCreatorsName: UILabel!
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tappedCommentsBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toCommentsSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = post.name{
            print(name )
            postName.text = name
        }
        if let shortDescript = post.shortDescript {
            postShortDescript.text = shortDescript
        }
        if let longDescript = post.longDescript{
            postLongDescript.text = longDescript
        }
        
        DataManager.dm.getImage(imgUrl: post.productUrl, returnBlock: {
            (returnedImg) in
            self.postImg.image = returnedImg
        })
        DataManager.dm.getImage(imgUrl: post.logoUrl, returnBlock: {
            (returnedImg) in
            self.postLogo.image = returnedImg
        })
        if let stage = post.prodStage {
            postStage.text = stage
        }
        if let creatorsName = post.creatorName {
            postCreatorsName.text = creatorsName
        }

        
        
    }
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest){
            case is CommentsVC:
            let destVC = dest as! CommentsVC
            destVC.post = self.post
            default:
            print("Default segue")
        }
    }
}
