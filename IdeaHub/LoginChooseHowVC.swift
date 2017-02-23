//
//  LoginChooseHowVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/16/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

import Firebase
import SwiftKeychainWrapper

class LoginChooseHowVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fbBtnTapped(_ sender: UIButton) {
            let facebookLogin = FBSDKLoginManager()
            
            facebookLogin.logIn(withReadPermissions: [ "public_profile", "email","user_birthday"], from: self) { (result, error) in
                if error != nil {
                    print("Chuck: Unable to authenticate with Facebook - \(error)")
                } else if result?.isCancelled == true {
                    print("Chuck: User cancelled Facebook authentication")
                } else {
                    print("Chuck: Successfully authenticated with Facebook")
                    print("result \(result)")
                    //Authenticate with Facebook
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    //Authenticatre with Firebase
                    var userData = [userDataTypes.provider: credential.provider]
                    //Grab user info
                    if((FBSDKAccessToken.current()) != nil){
                        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name,  email, gender, birthday, picture.type(large)"]).start(completionHandler:
                            { (connection, result, error) -> Void in
                                print("Chuck: Graph request connection? \(connection)")
                                if error != nil {
                                    print("Chuck: Error with FB graph request - \(error)")
                                } else {
                                    print("Chuck: Result from FB graph request - \(result)")
                                    if let result = result as? NSDictionary {
                                        if let birthday = result["birthday"] as? String{
                                            userData[userDataTypes.birthday] = birthday
                                        } else { print("Chuck: Could'nt grab FB birthday")}
                                        if let email = result["email"] as? String{
                                            userData[userDataTypes.email] = email
                                        } else { print("Chuck: Could'nt grab FB email")}
                                        if let name = result["name"] as? String {
                                            userData[userDataTypes.name] = name
                                        } else { print("Chuck: Could'nt grab FB name")}
                                        
                                        if let gender = result["gender"] as? String {
                                            userData[userDataTypes.gender] = gender
                                        } else { print("Chuck: Could'nt grab FB gender")}
                                        if let picture = result["picture"] as? NSDictionary {
                                            let data = picture["data"] as! NSDictionary
                                            let imgURL = data["url"]
                                            let url = NSURL(string:imgURL as! String)
                                            let urlRequest = NSURLRequest(url: url! as URL)
                                            
                                            NSURLConnection.sendAsynchronousRequest(urlRequest as URLRequest, queue: OperationQueue.main) {
                                                (response:URLResponse?, data:Data?, error:Error?) -> Void in
                                                if error == nil {
                                                    if let image = UIImage(data: data!) {
                                                        userImage = image
                                                        print("Chuck: successfully got facebook image")
                                                    } else { print("Chuck: Could not get facebook image from data") }
                                                } else {
                                                    print("Chuck: error with loading facebook image")
                                                }
                                            }
                                        } else { print("Chuck : No facebook image grabbed") }
                                        
                                    } else {
                                        print("Chuck: Could'nt cast result to NSDictionary")
                                    }
                                }
                                self.firebaseAuth(credential,userData:userData)
                        })
                    }
                    
                }
            
        }
    }
    
        
        
        func firebaseAuth(_ credential: FIRAuthCredential , userData:Dictionary<String, String>){
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print("Chuck: Unabe to authenticate with Firebase - \(error)")
                } else {
                    print("Chuck: Succesfully authenticated with Firebase")
                    if let user = user {
                        
                        self.completeSignIn(id: user.uid,userData: userData)
                    }
                }
            })
        }
        func completeSignIn(id:String, userData:Dictionary<String, String>){
            // for automatic sign in
            DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
            let KeychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
            print("Chuck: Data saved to keycahain \(KeychainResult)")
            presentMainTabVC(sender: self)
        }
    

    
    }
