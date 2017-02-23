//
//  FeedVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/14/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

//Global Variables
var currentUser:User!

class FeedVC: UIViewController {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var posterImage: RoundPic!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var postStage: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postLogo: RoundPic!
    
    @IBOutlet weak var swipeCardView: swipeCardShadowRoundCorner!
    var originalCenter:CGPoint! //used for swiping to return to the original position



    override func viewDidLoad() {
        super.viewDidLoad()

   
        if DataManager.dm.currentPost == nil {
            swipeCardView.isHidden = true 
        }
        //Swipe gesture stuff
        originalCenter = swipeCardView.frame.origin
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(FeedVC.wasDragged(_:)))
        swipeCardView.addGestureRecognizer(swipeGesture)
        
        //Get users info 
        DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let userDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key //What kind of key is this?
                        let user = User(userKey: key , userData: userDict)
                        print("Chuck: Added current user")
                        currentUser = user
                        
                    }
                }
            }
        })
        
        self.updateData()
    }
    
    
    func updateData(){
        print("CHUCK: Updating data for feedVC")
        //Downloads posts data then runs function when done
        DataManager.dm.getPosts(){
            //function to run when done
            self.nextPost()
        }
    }
    
    func nextPost() -> Void{
        print("next post")
    
        if let post = DataManager.dm.nextPost(){
            showPost(post: post)
        } else {
            print("No posts to show")
            swipeCardView.isHidden = true
        }
    }

    func showPost(post:Post){
        self.swipeCardView.isHidden = false
        configurePost(post: post)
        
    }
    func postWasSwiped( wasLiked: Bool){
        DataManager.dm.adjustLikesForCurrentPost(addLike: wasLiked)
        nextPost()
    }
    
    func configurePost(post: Post, img: UIImage? = nil) {

      
        self.postCaption.text = post.shortDescript
        self.postTitle.text = post.name
        //self.postStage.text = post.prodStage
    
        if let creatorName = post.creatorName {
            self.posterName.text = creatorName
        }
        
        DataManager.dm.getImage(imgUrl:post.productUrl){
            (img) in
            self.postImage.image = img
        }
        DataManager.dm.getImage(imgUrl: post.logoUrl){
            (img) in
            self.postLogo.image = img
        }
     
    }
    
 

    @IBAction func signOutBtnTapped(_ sender: Any) {
       
        try! FIRAuth.auth()!.signOut()
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        presentSignUpOrLoginVC(sender:self)
        
    }
    
    
    
    
    //MARK: - Gestures
    
    
    @IBAction func tappedPost(_ sender: Any) {
        print("Post Tapped")
        performSegue(withIdentifier: "toPostDetailSegue", sender: self)
    }
    
    func wasDragged(_ gesture: UIPanGestureRecognizer)
    {
        let translation = gesture.translation(in: self.view)
        let view = gesture.view!
        //print("\(view.subviews.first?.frame)")
        
        view.frame.origin = CGPoint(x: originalCenter.x + translation.x, y: self.originalCenter.y + translation.y) // relative to bottom left of screen
        let xFromCenter = view.center.x - self.view.bounds.width/2
        let scale = 1000 / (abs(xFromCenter) + 1000 )
        var rotation = CGAffineTransform(rotationAngle: 0)
        var stretch = rotation.scaledBy(x: scale, y: scale)
        view.transform = stretch
        //Below decides if it is a left or right drag
        if gesture.state == UIGestureRecognizerState.ended {
            if view.center.x < 100 {
                print("left drag")
                self.postWasSwiped( wasLiked: false)
            } else if view.center.x > self.view.bounds.width - 100 {
                print("right drag")
                self.postWasSwiped( wasLiked: true)
            }
            //Returns the view back to normal
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: 1, y: 1)
            view.transform = stretch
            view.frame.origin  = originalCenter
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest ){
        case is PostDetailVC:
            let destVC = dest as! PostDetailVC
            print("Going to PostDetailVC")
            let currentPost = DataManager.dm.currentPost
            print("Chuck: Showing post -\(currentPost?.name)")
            destVC.post = DataManager.dm.currentPost
        default:
            print("Segue Default ")
        }
    }

}
