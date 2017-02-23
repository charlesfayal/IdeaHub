//
//  LogInEmailVC.swift
//  Hatchling
//
//  Created by Steven Graf on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LogInEmailVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func dismissKeyboard() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func forgotPasswordBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "forgotPasswordSegue", sender: self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func logInBtnTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error != nil {
                    if (error != nil) {
                        // an error occurred while attempting login
                        if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
                            switch errCode {
                            case .errorCodeInvalidEmail:
                                self.presentUIAlert(title: "Invalid email", message: "Email is not in the correct format")
                            case .errorCodeWrongPassword:
                                self.presentUIAlert(title: "Invalid password", message: "Please enter the correct password")
                            case .errorCodeUserNotFound:
                                self.presentUIAlert(title: "User not found", message: "Make sure email is correct, or create an account")
                            default:
                                self.presentUIAlert(title: "Error logging in", message: "Please try again")
                                print("Chuck - Error logging in went to default error \(error)")
                                
                            }
                        }
                    }
                }else {
                    print("Chuck: Email authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                }
            })
        }
 
    }
        func completeSignIn(id:String, userData:Dictionary<String, String>){
            // for automatic sign in
            DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
            let KeychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
            print("Chuck: Data saved to keycahain \(KeychainResult)")
        
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "mainTabViewController")
                self.present(vc, animated: false, completion: nil)
                
            }
        }
    func presentUIAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let dest = segue.destination
        switch(dest){
            case is ForgotPWVC:
                let destVC = dest as! ForgotPWVC
                destVC.email = emailField.text!
            default:
                print("default")
        }
    }
    

}
