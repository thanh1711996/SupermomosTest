//
//  Target.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import Alamofire

protocol Target {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

