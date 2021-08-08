//
//  Manager.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import Alamofire
import ObjectMapper

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias ApiCompletion<T> = (Swift.Result<T, Error>) -> Void
typealias ApiLoadMoreCompletion<T> = (Swift.Result<T, Error>, _ total: Int) -> Void
class ApiManager {
    static var shared = ApiManager()
    static var pageLimit = 20
    static var initalMax = 999
    private init() { }

    var networkAvailable: Bool {
        switch NetworkReachabilityManager.shared.networkReachabilityStatus {
        case .unknown, .notReachable: return false
        case .reachable: return true
        }
    }
}

extension NetworkReachabilityManager {
    static let shared: NetworkReachabilityManager = {
        guard let manager = NetworkReachabilityManager() else {
            fatalError("Can't init network manager")
        }
        manager.listener = { status in
            NotificationCenter.default.post(.init(name: .networkStatusChange))
        }
        manager.startListening()
        return manager
    }()
}

extension Notification.Name {
    static let networkStatusChange = NSNotification.Name(rawValue: "networkStatusChange")
}
