//
//  ProfilleVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/29/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ProfileVC: UIViewController {

    
    @IBAction func signOutBtnTapped(_ sender: UIButton) {
        
        try! FIRAuth.auth()!.signOut()
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        presentSignUpOrLoginVC(sender:self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    


}
