//
//  SignUpEmailVC.swift
//  Hatchling
//
//  Created by Steven Graf on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

struct EmailLoginProfile{
    var fullName:String = ""
    var password:String = ""
    var email:String = ""
    var birthdate:Date = Date()
    var gender:String = ""
}
class SignUpEmailVC: UIViewController, UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        nameField.delegate = self
        passwordField.delegate = self
    }
    
    func dismissKeyboard() {
        emailField.resignFirstResponder()
        nameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        nameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        if (emailField.text == "" || nameField.text == "" || passwordField.text == "") {
            let alertController = UIAlertController(title: "Field Not Filled Out", message: "Please complete all fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            
            performSegue(withIdentifier: "toSignUpBirthdaySegue", sender: self)

        }
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
            case is SignUpBdayVC:
                let destVC = dest as! SignUpBdayVC
                var profile = EmailLoginProfile()
                profile.fullName = nameField.text!
                profile.email = emailField.text!
                profile.password = passwordField.text!
                destVC.profile = profile
        default:
            break
        }
  
        
    }
    

}
