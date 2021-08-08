//
//  Request.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

extension ApiManager {
    // MARK: - API Request
    /// Send a request to server
    ///
    /// - parameter target:  Target info of request Include: url, method, headers, params.
    ///
    public func request(target: Target, completion: @escaping ApiCompletion<Any>) -> DataRequest? {
        // check network available
        guard ApiManager.shared.networkAvailable else {
            let error = NSError(status: .noInternetConnection)
            completion(.failure(error))
            return nil
        }
        
        let encoding: ParameterEncoding
        if target.method == .post || target.method == .patch || target.method == .put {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }
        let request = Alamofire.request(target.path, method: target.method, parameters: target.params, encoding: encoding, headers: target.headers)
        request.responseJSON { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            
            case .failure(let error):
                let error = error as NSError
                guard let status = HTTPStatus(code: error.code) else {
                    completion(.failure(error))
                    return
                }
                let ownError = NSError(status: status)
                completion(.failure(ownError))
            }
        }
        return request
    }
}
