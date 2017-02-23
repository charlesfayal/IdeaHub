//
//  SignUpBdayVC.swift
//  Hatchling
//
//  Created by Steven Graf on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class SignUpBdayVC: UIViewController {
    var profile = EmailLoginProfile()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Chuck: Signing up \(profile.fullName) with email \(profile.email) and password \(profile.password)")
    }

    @IBOutlet weak var birthDayPicker: UIDatePicker!
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        let birthday = birthDayPicker.date
        let timeUntilBirthday = birthday.timeIntervalSinceNow
    
        if timeUntilBirthday > 0 {
            let alertController = UIAlertController(title: "Birthday in the future", message: "Please enter valid birthday", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)

            
        } else {
            profile.birthdate = birthday
            performSegue(withIdentifier: "toSignUpGenderSegue", sender: self)
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
            case is SignUpGenderVC:
                let destVC = dest as! SignUpGenderVC
                print("sign up gender")
                destVC.profile = profile
            
            default:
            break
        }
    }
 

}
