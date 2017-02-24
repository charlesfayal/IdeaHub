//
//  FeedVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/14/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

//Global Variables
var currentUser:User!

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{


    override func viewDidLoad() {
        super.viewDidLoad()



        //Get users info 
        DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key //What kind of key is this?
                        let user = User(userKey: key , userData: userDict)
                        print("Chuck: Added current user")
                        currentUser = user
                        
                    }
                }
            }
        })
        
        
        
    }
    
    //MARK: TableView Functions
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdeaTableViewCell") as! IdeaTableViewCell
        return cell
    }
    
    
    //MARK:

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest ){
        case is PostDetailVC:
            let destVC = dest as! PostDetailVC
            print("Going to PostDetailVC")
            let currentPost = DataManager.dm.currentPost
            print("Chuck: Showing post -\(currentPost?.name)")
            destVC.post = DataManager.dm.currentPost
        default:
            print("Segue Default ")
        }
    }

}
