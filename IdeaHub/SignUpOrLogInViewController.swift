//
//  SignUpOrLogInViewController.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/17/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SignUpOrLogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    override func viewDidAppear(_ animated: Bool) {
       if let _  = KeychainWrapper.standard.string(forKey: KEY_UID ){
            print("CHUCK: ID found in keychain")
            presentMainTabVC(sender: self)
        }
    }

}
