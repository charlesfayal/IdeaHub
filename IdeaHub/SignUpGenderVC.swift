//
//  SignUpGenderVC.swift
//  Hatchling
//
//  Created by Steven Graf on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class SignUpGenderVC: UIViewController {
    
    var profile = EmailLoginProfile()
    override func viewDidLoad() {
        super.viewDidLoad()
             print("Chuck: Signing up \(profile.fullName) with email \(profile.email) and password \(profile.password) and birthdate \(profile.birthdate)")
    }
    
    
    @IBOutlet weak var maleBtn: UIButton!

    @IBOutlet weak var femaleBtn: UIButton!
    
    @IBAction func maleBtnTapped(_ sender: Any) {
        maleBtn.setTitleColor(UIColor.black, for: .normal)
        femaleBtn.setTitleColor(UIColor.white, for: .normal)
        profile.gender = "male"
    }
    @IBAction func femaleBtnTapped(_ sender: Any) {
        femaleBtn.setTitleColor(UIColor.black, for: .normal)
        maleBtn.setTitleColor(UIColor.white, for: .normal)
        profile.gender = "female"
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //toSignUpConfirmSegue
    @IBAction func nextBtnTapped(_ sender: Any) {
        if profile.gender == "" {
            presentUIAlert(sender: self, title: "Gender not choosen", message: "Please choose one")

        } else {
            self.performSegue(withIdentifier: "toSignUpConfirmSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest){
        case is SignUpConfirmVC:
            print("going to confirm")
            let destVC = dest as! SignUpConfirmVC
            destVC.profile = profile
        default:
            print("default switch statement")
        }
    }
    

}
