//
//  ForgotPWVC.swift
//  Hatchling
//
//  Created by Steven Graf on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase
class ForgotPWVC: UIViewController, UITextFieldDelegate {
    var email:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if email != "" {
            emailField.text = email
        }
        emailField.delegate = self
    }
    
    func dismissKeyboard() {
        emailField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func sendEmailBtnTapped(_ sender: Any) {
        if emailField.text != "" {
        FIRAuth.auth()?.sendPasswordReset(withEmail: emailField.text!, completion: { (error) in
            if error != nil {
                print("Chuck: Reset email error - \(error)")
            } else {
                let alertController = UIAlertController(title: "Reset password", message: "Email sent", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
        })
        } else {
            let alertController = UIAlertController(title: "No email input", message: "Please provide email", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
