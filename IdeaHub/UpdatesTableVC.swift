//
//  UpdatesTableVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/3/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdatesTableVC: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var usersLikesUpdates:[Update] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)

        DataManager.dm.getUsersLikesUpdates { (updates) in
            print("Chuck getting updates")
            self.usersLikesUpdates = updates
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(UpdatesTableVC.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()

    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        DataManager.dm.getUsersLikesUpdates { (updates) in
            print("Chuck getting updates")
            self.usersLikesUpdates = updates
            self.tableView.reloadData()
        }
        
        // movies.sort() { $0.title < $1.title }
        print("refreshing")
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersLikesUpdates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "updatesTableViewCell") as! UpdatesTableViewCell
        let update = usersLikesUpdates[indexPath.row]
        if let descript = update.description {
            cell.updateDescript.text = descript
        }
        if update.prodName != nil{
            cell.prodName.text = update.prodName
        }
        if update.link != nil  {
            cell.updateLink.setTitle(update.link, for: .normal)
        } else {
            cell.updateLink.isHidden = true
        }
        cell.update = update
        DataManager.dm.getImage(imgUrl: update.prodLogoUrl!, returnBlock: {
            (returnedImg) in
            cell.prodLogo.image = returnedImg
        })
        return cell
    }
}
