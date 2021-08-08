//
//  UserTarget.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import Alamofire

enum UserTarget {
    case listUser
    case getUser(id: String)
}

func / (lhs: String, rhs: String) -> String {
    return lhs + "/" + rhs
}

extension UserTarget: Target {
    
    static let baseApi = "https://api.github.com/users"
    
    var path: String {
        switch self {
        case .listUser:
            return UserTarget.baseApi
        case .getUser(let id):
            return UserTarget.baseApi / id
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .listUser, .getUser:
            return .get
        }
    }
    
    var params: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


