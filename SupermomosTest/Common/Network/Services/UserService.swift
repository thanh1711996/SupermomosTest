//
//  UserService.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import ObjectMapper

class UserService {
    func getListUser(completion: @escaping ApiCompletion<[UserModel]>) {
        let target = UserTarget.listUser
        _ = ApiManager.shared.request(target: target, completion: { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                guard let data = Mapper<UserModel>().mapArray(JSONObject: response) else {
                    completion(.failure(NSError.noResponse))
                    return
                }
                completion(.success(data))
            }
        })
    }
    
    func getUser(id: String, completion: @escaping ApiCompletion<UserModel>) {
        let target = UserTarget.getUser(id: id)
        _ = ApiManager.shared.request(target: target, completion: { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                guard let object = response as? JSObject, let data = Mapper<UserModel>().map(JSON: object) else {
                    completion(.failure(NSError.noResponse))
                    return
                }
                completion(.success(data))
            }
        })
    }
}
