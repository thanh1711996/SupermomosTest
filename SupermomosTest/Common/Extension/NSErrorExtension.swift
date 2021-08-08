//
//  NSErrorExtension.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import Alamofire

extension NSError {
    convenience init(domain: String? = nil, status: HTTPStatus, message: String? = nil) {
        let domain = domain ?? Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message ?? status.description]
        self.init(domain: domain, code: status.code, userInfo: userInfo)
    }

    public convenience init(domain: String? = nil, code: Int = -999, message: String?) {
        let domain = domain ?? Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message ?? ""]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
}
