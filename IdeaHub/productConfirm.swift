//
//  productConfirm.swift
//  Hatchling
//
//  Created by Steven Graf on 1/19/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase

class productConfirm: UIViewController, hasDataDict {
    var dataDict: Dictionary<String, AnyObject> = [:]
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var creatorPicture: RoundPic!
    @IBOutlet weak var prodNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var logoImageView: RoundPic!
    
    @IBOutlet weak var prodCategoriesLabel: UILabel!
    @IBOutlet weak var prodLongDescriptLabel: UILabel!
    
    @IBOutlet weak var prodShortDescriptLAbel: UILabel!
    @IBOutlet weak var prodCreatorLabel: UILabel!
    @IBOutlet weak var prodStageLabel: UILabel!
    @IBOutlet weak var prodNeedsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let prodImg = dataDict[postDataTypes.productImg]  {
            productImageView.image = prodImg as? UIImage
        }
        if let logoImg = dataDict[postDataTypes.logoImg] {
            logoImageView.image = logoImg as? UIImage
        }
        if let productNeeds = dataDict[postDataTypes.prodNeeds] {
            prodNeedsLabel.text = productNeeds as? String
        }
        let shortDescript = dataDict[postDataTypes.shortDescript]
        let longDescript = dataDict[postDataTypes.longDescript]
        let productName = dataDict[postDataTypes.name]
        let productCategories = dataDict[postDataTypes.prodCategories]
        
        prodShortDescriptLAbel.text  = shortDescript as? String
        prodLongDescriptLabel.text = longDescript as? String
        prodNameLabel.text = productName as? String
        prodCategoriesLabel.text = productCategories as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postBtnTapped(_ sender: AnyObject) {
      /*   guard let caption = captionField.text, caption != "" else {
            print("JESS: Caption must be entered")
            return
        }
        guard let img = imageAdd.image, imageSelected == true else {
            print("JESS: An image must be selected")
            return
        }*/
    
        //NEED PROTECTION HERE
        postProudctImg()
    }
    var productUrl = ""
    var logoUrl = ""
    func postProudctImg(){
        let productImg = dataDict[postDataTypes.productImg] as! UIImage
        dataDict.removeValue(forKey: postDataTypes.productImg)
    
        if let productImgData = UIImageJPEGRepresentation(productImg, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(productImgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Chuck: Unable to upload image to Firebasee torage")
                } else {
                    print("Chuck: Successfully uploaded image to Firebase storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        
                         self.productUrl = url
                        //postLogoImg(imgUrl: url)
                        self.dataDict[postDataTypes.productUrl] = url as AnyObject
                        self.postLogoImg()
                    }
                }
            }
        }
    }
    
    func postLogoImg(){
        let logoImg = dataDict[postDataTypes.logoImg] as! UIImage
        dataDict.removeValue(forKey: postDataTypes.logoImg)

        if let logoImgData = UIImageJPEGRepresentation(logoImg, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(logoImgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Chuck: Unable to upload image to Firebasee torage")
                } else {
                    print("Chuck: Successfully uploaded image to Firebase storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.dataDict[postDataTypes.logoUrl] = url as AnyObject
                        self.logoUrl = url
                        self.postToFirebase()
                    }
                }
            }
        }
    }
    
    func postToFirebase() {
        var  creatorName = "Anonymous"
        
    
        //TEMPORARY NEED TO DO SOMETHIGN ABOUT THIS NOT WORKING
        guard let user = currentUser else {
            print("Chuck: no current user")
            return
        }

 
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        let postId = firebasePost.key
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.posts).child(postId).setValue(true)
        firebasePost.setValue(dataDict)
        presentMainTabVC(sender: self)
    }


}
