//
//  RealmManager.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import RealmSwift
import RxCocoa
import RxRealm
import RxSwift

class RealmManager {
    static var shared = RealmManager()
    
    func getUsersObject() -> [UserObject] {
        let realm = try! Realm()
        let users = realm.objects(UserObject.self).sorted(byKeyPath: "id")
        return users.toArray()
    }
    
    func getUserObject(id: String) -> UserObject? {
        let realm = try! Realm()
        let users = realm.objects(UserObject.self).filter("login = %@", id)
        return users.first
    }
    
    func addUsersObject(object: [UserObject]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: .all)
        }
    }
}
