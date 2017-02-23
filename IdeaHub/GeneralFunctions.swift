//
//  GeneralFunctions.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
import UIKit
 //Simple UIalert function...
func presentUIAlert(sender: UIViewController, title:String, message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    sender.present(alertController, animated: true, completion: nil)
    
}
   /**
    Performs a segue from whatever UIViewController to the Feed VC
 */
func presentMainTabVC(sender: UIViewController){
    let storyboard = UIStoryboard(name: myStoryboards.main, bundle: Bundle.main)
    let vc = storyboard.instantiateViewController(withIdentifier: "mainTabViewController")
    sender.present(vc, animated: true, completion: nil)
}
func presentSignUpOrLoginVC(sender:UIViewController){
    let storyboard = UIStoryboard(name: myStoryboards.logOrSignIn, bundle: Bundle.main)
    let vc = storyboard.instantiateViewController(withIdentifier: "SignUpOrLogInViewController")
    sender.present(vc, animated: true, completion: nil)
}
func presentCreatProductDetailsVC(sender:UIViewController){
    let storyboard = UIStoryboard(name: myStoryboards.createProduct, bundle: Bundle.main)
    let vc = storyboard.instantiateViewController(withIdentifier: "CreateProductDetailsVC")
    sender.present(vc, animated: true, completion: nil)
}
