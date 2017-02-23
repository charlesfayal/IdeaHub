//
//  Comment.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/7/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation

struct commentDataTypes{
    static let content = "content"
    static let creatorUserName = "creatorUserName"
    static let creatorKey = "creatorKey"
    
}
struct commentChainDataTypes {
    static let comments = "comments"
    static let postKey = "postKey"
}
class Comment{
    private var _creatorKey:String!
    private var _content:String!
    var content:String { return _content }
    private var _creatorUserName:String!
    
    init(content:String){
        self._content = content
        self._creatorUserName = currentUser.name ?? "Anonymous" // Figure this out
        self._creatorKey = currentUser.key
    }
    init(commentData:Dictionary<String,AnyObject>){
        
        if let content =  commentData[commentDataTypes.content] as? String{
            self._content = content
        }
        if let creatorUserName =  commentData[commentDataTypes.creatorUserName] as? String{
            self._creatorUserName = creatorUserName
        }
        if let creatorKey =  commentData[commentDataTypes.creatorKey] as? String{
            self._creatorKey = creatorKey
        }
    }
    func createDictForFirebase() -> Dictionary<String, AnyObject>{
        
        let commentDict: Dictionary<String,AnyObject> = [
            commentDataTypes.content : self._content as AnyObject,
            commentDataTypes.creatorUserName : self._creatorUserName as AnyObject,
            commentDataTypes.creatorKey : self._creatorKey as AnyObject
        ]
        return commentDict

    }
    
}
