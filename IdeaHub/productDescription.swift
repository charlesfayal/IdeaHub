//
//  productDescription.swift
//  Hatchling
//
//  Created by Steven Graf on 1/18/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class productDescription: UIViewController, hasDataDict {
    var dataDict: Dictionary<String, AnyObject> = [:]
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    
    @IBOutlet weak var shortProdDescriptionField: textViewRoundCorners!
    @IBOutlet weak var longProdDescriptionField: textViewRoundCorners!
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        let shortDescript = shortProdDescriptionField.text
        let longDescript = longProdDescriptionField.text
        if shortDescript == "" || longDescript == "" {
            presentUIAlert(title: "Field not filled out", message: "Please fill out both descriptions")
        } else {
            dataDict[postDataTypes.shortDescript] = shortDescript as AnyObject
            dataDict[postDataTypes.longDescript] = longDescript as AnyObject
            self.performSegue(withIdentifier: "toCreateProductPicsSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination
        switch(dest){
        case is hasDataDict:
            var destVC = dest as! hasDataDict
            destVC.dataDict = self.dataDict
        default:
            print("Default in switch statment")
        }
    }
    
    func presentUIAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

}
