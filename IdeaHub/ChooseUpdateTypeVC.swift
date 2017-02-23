//
//  ChooseUpdateTypeVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

struct updateTypes{
    static let betaTesting = "betaTesting"
    static let crowdfunding = "crowdfunding"
    static let preorders = "preorders"
    static let launch = "launch"
}
class ChooseUpdateTypeVC: UIViewController, hasUpdateVar, hasPostVar {

    var post:Post!
    var update:Update!
    
    @IBAction func tappedBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedBetaTesting(_ sender: Any) {
        update.updateType = updateTypes.betaTesting
        print("Chuck - User chose update type -\(update.updateType)")
        self.performSegue(withIdentifier: "toNextCreateUpdateVCSegue", sender: self)
    }
    
    @IBAction func tappedCrowdfundingBtn(_ sender: Any) {
        update.updateType = updateTypes.crowdfunding
        self.performSegue(withIdentifier: "toNextCreateUpdateVCSegue", sender: self)
    }
    
    @IBAction func tappedPreorderBtn(_ sender: Any) {
        update.updateType = updateTypes.preorders
        self.performSegue(withIdentifier: "toNextCreateUpdateVCSegue", sender: self)
    }
    @IBAction func tappedProdLaunchBtn(_ sender: Any) {
        update.updateType = updateTypes.launch
        self.performSegue(withIdentifier: "toNextCreateUpdateVCSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update = Update(forPost:post)
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
        case is hasUpdateVar:
            var destVC = dest as! hasUpdateVar
            destVC.update = update
        default:
            print("Default")
        }
    }
    

}
