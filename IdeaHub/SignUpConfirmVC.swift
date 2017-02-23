//
//  SignUpConfirmVC.swift
//  Hatchling
//
//  Created by Steven Graf on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
class SignUpConfirmVC: UIViewController {
    var profile = EmailLoginProfile()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Chuck: Signing up \(profile.fullName) with email \(profile.email) and password \(profile.password) and birthdate \(profile.birthdate) and gender \(profile.gender)")
        fullNameLabel.text = profile.fullName
        emailLabel.text = profile.email
        genderLabel.text = profile.gender
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let formattedBD = dateFormatter.string(from: profile.birthdate)
        birthdayLabel.text = formattedBD
    }
    
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func signUpBtnTapped(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: profile.email, password: profile.password, completion: { (user, error) in
            if error == nil {
                print("Chuck: Successfully authenticated with Firebase and email")
                if let user = user {
                    let userData = ["provider": user.providerID, "name": self.profile.fullName,"email":self.profile.email, "gender":self.profile.gender,"birthday":self.profile.birthdate.description]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            } else {
                if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
                    switch errCode {
                    case .errorCodeEmailAlreadyInUse:
                        presentUIAlert(sender:self, title: "Email already in use", message: "Please try another email")
                    case .errorCodeInvalidEmail:
                        presentUIAlert(sender:self, title: "Invalid Email", message: "Email is not in the correct format")
                    default:
                        print("Chuck: Erorr signing up with email - \(error)")

                    }
                }
            }
        })
    }
    
    func completeSignIn(id:String, userData:Dictionary<String, String>){
        // for automatic sign in
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let KeychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Chuck: Data saved to keycahain \(KeychainResult)")
        presentMainTabVC(sender:self)
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
