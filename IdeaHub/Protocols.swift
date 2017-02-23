//
//  Protocols.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/9/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import Foundation


protocol hasPostVar {
    var post:Post! { get set }
    
}
/*
extension hasPostVar {
    var post: Post! {
        get { return self.post }
        set { post = newValue}
    }
}*/
protocol hasUpdateVar {
    var update:Update! { get set }
    
}

protocol hasDataDict{
    var dataDict:Dictionary<String,AnyObject> {get set}
   // func addToDataDict(key: String, object: Any)
   // func getFromDataDict(key:String) -> AnyObject
}




