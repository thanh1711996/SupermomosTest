//
//  UserModel.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import ObjectMapper

class UserModel : Response {
    var login: String?
    var id: Int = 0
    var htmlUrl: String?
    var avatarUrl: String?
    var avatarData: Data?
    
    var name: String?
    var location: String?
    var followers: Int = 0
    var following: Int = 0
    var publicRepos: Int = 0
    var bio: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        login <- map["login"]
        id <- map["id"]
        avatarUrl <- map["avatar_url"]
        htmlUrl <- map["html_url"]
        
        name <- map["name"]
        location <- map["location"]
        followers <- map["followers"]
        following <- map["following"]
        publicRepos <- map["public_repos"]
        bio <- map["bio"]
    }
    
    convenience init (userObject: UserObject) {
        self.init()
        
        login = userObject.login
        id = userObject.id
        htmlUrl = userObject.htmlUrl
        avatarUrl = userObject.avatarUrl
        avatarData = userObject.avatarData
        
        name = userObject.name
        location = userObject.location
        followers = userObject.followers
        following = userObject.following
        publicRepos = userObject.publicRepos
        bio = userObject.bio
    }
}

