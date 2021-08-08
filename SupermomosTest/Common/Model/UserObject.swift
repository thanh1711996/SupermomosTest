//
//  UserObject.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import Foundation
import RealmSwift

class UserObject: Object {
    @objc dynamic var login: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var htmlUrl: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var avatarData: Data?
    
    @objc dynamic var name: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var followers: Int = 0
    @objc dynamic var following: Int = 0
    @objc dynamic var publicRepos: Int = 0
    @objc dynamic var bio: String = ""
    
    override static func primaryKey() -> String? { return "login" }
    
    convenience init(userModel: UserModel) {
        self.init()
        
        login = userModel.login ?? ""
        id = userModel.id
        htmlUrl = userModel.htmlUrl ?? ""
        avatarUrl = userModel.avatarUrl ?? ""
        avatarData = userModel.avatarData
        
        name = userModel.name ?? ""
        location = userModel.location ?? ""
        followers = userModel.followers
        following = userModel.following
        publicRepos = userModel.publicRepos
        bio = userModel.bio ?? ""
    }
}
