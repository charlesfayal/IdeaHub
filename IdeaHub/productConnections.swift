//
//  productConnections.swift
//  Hatchling
//
//  Created by Steven Graf on 1/19/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class productConnections: UIViewController, hasDataDict {
    
    var dataDict: Dictionary<String, AnyObject> = [:]
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var facebookField: UITextField!
    @IBOutlet weak var instagramField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var crowdfundingField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        let website = websiteField.text
        let facebook = facebookField.text
        let instagram = instagramField.text
        let email = emailField.text
        let crowdfunding = crowdfundingField.text
        let twitter = twitterField.text
        if website != "" {
            dataDict[postDataTypes.website] = website as AnyObject?
        }
        if facebook != "" {
            dataDict[postDataTypes.facebook] = facebook as AnyObject
        }
        if instagram != "" {
            dataDict[postDataTypes.instagram] = instagram as AnyObject
        }
        if email != "" {
            dataDict[postDataTypes.email] = email as AnyObject
        }
        if crowdfunding != "" {
            dataDict[postDataTypes.crowdfunding] = crowdfunding as AnyObject
        }
        if twitter != "" {
            dataDict[postDataTypes.twitter] = twitter as AnyObject
        }
        self.performSegue(withIdentifier: "toConfirmPostSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        case is hasDataDict:
            var destVC = dest as! hasDataDict
            destVC.dataDict = self.dataDict
        default:
            print("Default in switch statment")
        }
    
    }
    

}
