//
//  PostViewModel.swift
//  Insta_Clone
//
//  Created by Keval Patel on 4/16/19.
//  Copyright © 2019 Keval Patel. All rights reserved.
//

import Foundation
struct PostViewModel{
    //    let attribution : String
    //    var caption : Dictionary<String,Any>
    //    let comments : Dictionary<String,Any>
    //    let created_time : String
    //    let filter : String
    //    let id : String
    var images : Dictionary<String,Any>
    //    let likes : Dictionary<String,String>
    //    let link : String
    //    let location : Dictionary<String,Any>
    var tags : [String]
    //    let type : String
    //    let user : Dictionary<String,String>
    //    let user_has_liked : String
    //    let users_in_photo : [String]
    init(_ postModel : PostModel) {
        self.images = postModel.images
        self.tags = postModel.tags
    }
}
