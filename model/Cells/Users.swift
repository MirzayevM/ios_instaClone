//
//  Users.swift
//  ios_instaClone
//
//  Created by Mirzabek on 04/11/22.
//

import Foundation

struct User:Hashable{
    
    var uid : String?
    var email : String?
    var displayname : String?
    var password : String?
    var imgUser : String?
    
    var isFollowed: Bool = false
    
    init(uid: String? = nil, email: String? = nil, displayname: String? = nil) {
        self.uid = uid
        self.email = email
        self.displayname = displayname
    }
    
    init(uid: String? = nil, email: String? = nil, displayname: String? = nil,password:String? = nil
         ,imgUser:String? = nil) {
        self.uid = uid
        self.email = email
        self.displayname = displayname
        self.password = password
        self.imgUser = imgUser
    }
    
    init(uid: String? = nil, email: String? = nil, displayname: String? = nil
         ,imgUser:String? = nil) {
        self.uid = uid
        self.email = email
        self.displayname = displayname
        self.imgUser = imgUser
    }
    
    
}
