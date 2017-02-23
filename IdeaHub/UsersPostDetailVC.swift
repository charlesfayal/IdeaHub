//
//  UsersPostDetailVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UsersPostDetailVC: UIViewController, hasPostVar {
    var post:Post!
    
    
 
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postLogoImg: RoundPic!
    @IBOutlet weak var postShortDescript: UILabel!
    
    @IBOutlet weak var postLongDescript: UILabel!
    
    @IBOutlet weak var postCreatorsName: UILabel!
    
    @IBOutlet weak var postNeeds: UILabel!
    @IBOutlet weak var postStage: UILabel!
    @IBOutlet weak var postCategories: UILabel!
    
    @IBAction func tappedBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tappedCommentBtn(_ sender: Any) {
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
            self.postLogoImg.image = returnedImg
        })
        if let stage = post.prodStage {
            postStage.text = stage
        }
        if let creatorsName = post.creatorName {
            postCreatorsName.text = creatorsName
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let dest = segue.destination
        switch(dest){
            case is hasPostVar:
                var destVC = dest as! hasPostVar
                destVC.post = self.post
            default:
            print("Default segue switch")
        }
    }
    

}
