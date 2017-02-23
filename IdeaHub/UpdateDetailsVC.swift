//
//  UpdateDetailsVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class UpdateDetailsVC: UIViewController, hasUpdateVar{
    var update:Update!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    
    @IBOutlet weak var updateDescript: textViewRoundCorners!
    @IBOutlet weak var updateLink: UITextField!
    
    @IBAction func tappedBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedNextBtn(_ sender: Any) {
        if updateDescript.text == ""  {
            presentUIAlert(title: "Description not filled out", message: "Please fill in Description")

        } else {
            update.description = updateDescript.text
            if updateLink.text != "" {
                update.link = updateLink.text!
            }
            self.performSegue(withIdentifier: "toNextCreateUpdateVCSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Below sets the text on the screen depending on the update type
        switch(update.updateType){
        case updateTypes.launch:
            titleLabel.text = "Launch"
            explanationLabel.text = launchExplanation
        case updateTypes.betaTesting:
            titleLabel.text = "Beta Testing"
            explanationLabel.text = betaExplanation
        case updateTypes.preorders:
            titleLabel.text = "Taking Preorders"
            explanationLabel.text = preordersExplanation
        case updateTypes.crowdfunding:
            titleLabel.text = "Crowdfunding"
            explanationLabel.text = crowdfundingExplanation
        default:
            print("Chuck: had a update type onot in update types struct or update did not get a type")
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
        case is hasUpdateVar:
            var destVC = dest as! hasUpdateVar
            destVC.update = update
        default:
            print("Default")
        }
    }
    
    func presentUIAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //Descriptions for UI
    private let betaExplanation = "Create a beta testing update if you are looking for people to try out your product and give you feedback. Submit a link to where beta testers can download or look at your product."
    private let crowdfundingExplanation = "Create a crowdfunding update if you are starting a crowdfunding campaign and want followers to know. Submit a link to the campaign so followers can find it."
    private let preordersExplanation = "Create a pre-order update if you are taking pre-orders and want to let your followers know. Submit a link to the pre-order page so followers can find it."
    private let launchExplanation = "Create a launch update if you are officially launching your product and want all your followers know. Submit a link to the product web page so followers can find it."

}
