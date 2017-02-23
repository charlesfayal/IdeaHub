//
//  CreateProductDetails.swift
//  Hatchling
//
//  Created by Steven Graf on 1/18/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class CreateProductDetails: UIViewController, UITextFieldDelegate, hasDataDict {
    var dataDict: Dictionary<String, AnyObject> = [String: AnyObject]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    
    @IBAction func backBtnATapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var stageView: UIView!
    @IBOutlet weak var needsView: UIView!
    @IBOutlet weak var categoryView: UIView!
    //Labels
    @IBOutlet weak var prodStageLabel: UILabel!
    @IBOutlet weak var prodCategoriesLabel: UILabel!
    @IBOutlet weak var prodTalentLabel: UILabel!
    
    @IBOutlet weak var prodNameLabel: UITextField!
    
    private var stage:String = ""
    private var categories:[String] = []
    private var needs:[String] = []
    //Option Buttons Outlet and Action
        //Stage

    @IBAction func categoryBtnTapped(_ sender: UIButton) {
        let text = (sender.titleLabel?.text)!
        prodCategoriesLabel.text?.append("\(text) ")
        categories.append(text)
    }
    @IBAction func needBtnTapped(_ sender: UIButton) {
        let text = (sender.titleLabel?.text)!
        if text.contains("Clear"){
            prodTalentLabel.text = ""
            needs.removeAll()
        } else {
            prodTalentLabel.text?.append("\(text) ")

        }
        needs.append(text)
    }
    @IBAction func stageBtnTapped(_ sender: UIButton) {
        let text = (sender.titleLabel?.text)!
        prodStageLabel.text = text
        stage = text

    }
    //Choose buttons tapped and x buttons tapped
    @IBAction func ProdStageBtnTapped(_ sender: Any) {
        categoryView.isHidden = true
        stageView.isHidden = false
        needsView.isHidden = true
        
    }
    @IBAction func stageXBtnTapped(_ sender: Any) {
        stageView.isHidden = true
    }
    @IBAction func prodCategoriesBtnTapped(_ sender: Any) {
        categoryView.isHidden = false
        stageView.isHidden = true
        needsView.isHidden = true

    }
    @IBAction func categoriesXBtnTapped(_ sender: Any) {
        categoryView.isHidden = true

    }
    @IBAction func needsBtnTapped(_ sender: Any) {
        categoryView.isHidden = true
        stageView.isHidden = true
        needsView.isHidden = false
        
    }
    @IBAction func needsXBtnTapped(_ sender: Any) {
        needsView.isHidden = true
    }

    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        let prodName = prodNameLabel.text
        if prodName == "" || stage == "" || categories.count == 0 {
            presentUIAlert(title: "Sections not filled out", message: "Please fill out all sections")
        } else {
            dataDict[postDataTypes.name] = prodName as AnyObject
            dataDict[postDataTypes.prodStage] = stage as AnyObject
            dataDict[postDataTypes.prodCategories] = categories as AnyObject
            dataDict[postDataTypes.prodNeeds] = needs as AnyObject

            self.performSegue(withIdentifier: "toCreateDescriptionSegue", sender: self)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prodNameLabel.delegate = self
    }
    
    func dismissKeyboard() {
        prodNameLabel.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        prodNameLabel.resignFirstResponder()
        return true
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
