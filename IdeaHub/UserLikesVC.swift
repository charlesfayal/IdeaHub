//
//  UserLikesVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase

class UserLikesVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var usersLikes:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.dm.getUsers(userDataType: userDataTypes.likes ,returnBlock: {
            (returnPosts) in
            self.usersLikes = returnPosts
            print("Users likes - \(self.usersLikes)")
            self.tableView.reloadData()
            
        })

        
    }
    


    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersLikes.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likesTableViewCell", for: indexPath) as! LikesTableViewCell
        let post = usersLikes[indexPath.row]
        cell.prodName.text = post.name
        cell.prodShortDescript.text = post.shortDescript
        DataManager.dm.getImage(imgUrl: post.logoUrl, returnBlock: {
            (returnedImg) in
            cell.prodoLogoImg.image = returnedImg
        })
        return cell
    }
    
    var selectedPost:Post!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedPost = usersLikes[indexPath.row]
        self.performSegue(withIdentifier: "toPostDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest ){
            case is PostDetailVC:
                let destVC = dest as! PostDetailVC
                destVC.post = selectedPost
            default:
                print("Default")
        }
    }
    
    


}
