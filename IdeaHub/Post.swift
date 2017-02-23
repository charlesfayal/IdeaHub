//
//  Post.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/15/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation
import Firebase


//Strings for accessing firebase data
struct postDataTypes{
    static let commentChainKey = "commentChainKey"
    static let creator = "creator"
    static let shortDescript = "shortDescription"
    static let longDescript = "longDescript"
    static let likes = "likes"
    static let name = "name"
    static let logoUrl = "imgUrl"
    static let productUrl = "productUrl"
    static let logoImg = "logoImg"
    static let productImg = "productImg"
    static let prodStage = "prodStage"
    static let prodCategories = "prodCategories"
    static let prodNeeds = "prodNeeds"
    static let totalViews = "totalViews"
    static let likedBy = "likedBy" //a list of the uids of the people who have likd their product.
    static let facebook = "facebook"
    static let instagram = "instagram"
    static let twitter = "twitter"
    static let email = "email"
    static let crowdfunding = "crowdfunding"
    static let website = "website"
}
struct stageTypes {
    static let launch = "Launch"
    static let testing = "Testing"
    static let development = "Development"
    static let validation = "Validation"
    static let fundraising = "Fundraising"
}
class Post {
    
    //social media
    private var _facebook:String!
    private var _instagram:String!
    private var _twitter:String!
    private var _email:String!
    private var _crowdfunding:String!
    private var _website:String!
    //Basic
    private var _commentChainKey:String! // Firebase key for the comment chain
    private var _creatorName:String! // username of the creator
    private var _name: String!
    private var _shortDescript: String!
    private var _longDescript:String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    private var _productUrl: String!
    private var _logoUrl: String!
    private var _likedBy:[String]!
    //Stage
    private var _prodStage:String!
    private var _prodCategories:String!
    private var _prodNeeds:String!
    private var _totalViews:Int!
    //Media
    private var _productImg:UIImage!
    private var _logoImg:UIImage!
    
    var commentChainKey:String? {
        get {
            return _commentChainKey }
    }
    var shortDescript :String? { return _shortDescript }
    var longDescript:String? { return _longDescript }

    var creatorName: String? {
        return _creatorName
    }
    var likes: Int {
        return _likes
    }
    var postKey:String {
        return _postKey
    }
    var name:String? {
        return _name
    }
    var productUrl:String{
        return _productUrl
    }
    var logoUrl:String{
        return _logoUrl
    }
    var productImg:UIImage? { return _productImg }
    var totalViews: Int{ return _totalViews }
    var likedBy: [String]{ return _likedBy }
    var logoImg:UIImage? { return _logoImg }
    var prodStage:String? {return _prodStage}
    var prodCategories:String? { return _prodCategories }
    var prodNeeds:String? { return _prodNeeds }
    //socia media
    var facebook:String { return _facebook }
    var twitter: String { return _twitter}
    var instagram: String {return _instagram}
    var email :String { return _email}
    var crowdfunding :String {return _crowdfunding}
    var website : String { return _website}


    init( postKey: String , postData: Dictionary<String, AnyObject> ){
        self._postKey = postKey
        if let commentChainKey = postData[postDataTypes.commentChainKey] as? String{
            self._commentChainKey = commentChainKey
        } else {
        }
        if let creatorName = postData[postDataTypes.creator] as? String {
            self._creatorName = creatorName
        }
        if let shortDescript = postData[postDataTypes.shortDescript] as? String{
            self._shortDescript = shortDescript
        }
        if let longDescript = postData[postDataTypes.longDescript] as? String {
            self._longDescript = longDescript
        }
        if let likes = postData[postDataTypes.likes] as? Int{
            self._likes = Int(likes)
        } else {
            self._likes = 0
        }
        if let productUrl = postData[postDataTypes.productUrl] as? String{
            self._productUrl = productUrl
        }
        if let logoUrl = postData[postDataTypes.logoUrl] as? String{
            self._logoUrl = logoUrl
        }
        if let name = postData[postDataTypes.name] as? String {
            self._name = name
        }
        if let prodStage = postData[postDataTypes.prodStage] as? String {
            self._prodStage = prodStage
        }
        if let prodCategories = postData[postDataTypes.prodCategories] as? String {
            self._prodCategories = prodCategories
        }
        if let totalViews = postData[postDataTypes.totalViews] as? Int {
            self._totalViews = Int(totalViews)
        } else {
            self._totalViews = 0
        }
        if let facebook = postData[postDataTypes.facebook] as? String {
            self._facebook = facebook
        }
        if let twitter = postData[postDataTypes.twitter] as? String {
            self._twitter = twitter
        }
        if let email = postData[postDataTypes.email] as? String {
            self._email = email
        }
        if let crowdfunding = postData[postDataTypes.crowdfunding] as? String {
            self._crowdfunding = crowdfunding
        }
        if let instagram = postData[postDataTypes.instagram] as? String {
            self._instagram = instagram
        }
        
        _postRef = DataService.ds.REF_POSTS.child(_postKey)
    }
    
    /**
     Tries to get the commentChainKey from firebase, if it can't get it, then it will create one
 */
    func getCommentChainKey(withCompletionBlock:@escaping (_ key:String) -> Void){
        _postRef.child(postDataTypes.commentChainKey).observeSingleEvent(of: .value, with: {
            (snapshot) in
            print("Chuck: Comment chain snapshot value-\( snapshot.value)")
            if let commentChain = snapshot.value as? String {
                self._commentChainKey = commentChain
                guard self._commentChainKey != nil else {
                    self.addNewCommentChainKey()
                    return
                }
                withCompletionBlock(self._commentChainKey)
            }
        })
    }
    
    func addNewCommentChainKey(){
        let commentChainRefKey = DataService.ds.REF_COMMENT_CHAIN.childByAutoId()
        self._commentChainKey = commentChainRefKey.key
        commentChainRefKey.child(commentChainDataTypes.postKey).setValue(self._postKey)

    }
    func adjustLikes(addLike: Bool) {
        //add post to this users likes
        DataService.ds.REF_USER_CURRENT.child(userDataTypes.likes).child(_postKey).setValue(true)
        _postRef.child(postDataTypes.likedBy).child(DataService.ds.REF_USER_CURRENT.key).setValue(true) // doesn't need to be in transaction block because you are simply adding a value instead of updating

        //Below basically gets the most up to date info and adds the likes and total views. without this the data could be stale
        print(_postRef)
        _postRef.runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
            if var postData = currentData.value as? [String : AnyObject] {
                print("CHUCK: Adjusting likes on - \(postData)")
                var currentLikes:Int
                var currentViews:Int
                
                currentLikes = postData[postDataTypes.likes] as? Int ?? 0
                currentViews = postData[postDataTypes.totalViews] as? Int ?? 0
                if addLike {
                    currentLikes += 1
                } else {
                    //currentLikes -= 1
                }
                currentViews += 1
                postData[postDataTypes.likes] = currentLikes as AnyObject?
                postData[postDataTypes.totalViews] = currentViews as AnyObject?
                
                // Set value and report transaction success
                currentData.value = postData
                
                return FIRTransactionResult.success(withValue: currentData)
            }
            return FIRTransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
