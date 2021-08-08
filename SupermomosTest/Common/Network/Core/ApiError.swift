//
//  ApiError.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation

extension NSError {
    static let serviceError = NSError(status: .serviceError)
    static let noResponse = NSError(status: .noResponse)
    static let parseError = NSError(status: .noResponse)
    static let noInternetConnection = NSError(status: .noInternetConnection)
    static let serverError = NSError(status: .internalServerError)
    static let badGateway = NSError(status: .badGateway)
    static let unauthorized = NSError(status: .unauthorized)
    static func serviceError(with message: String, code: Int) -> Error {
        return NSError(domain: nil, code: code, message: message) as Error
    }
}
