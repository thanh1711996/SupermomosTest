//
//  BaseViewModelChange.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import Foundation

// event model change
enum BaseViewModelChange {
    case loaderStart
    case loaderEnd
    case updateDataModel(data: Response?)
    case error(message: String)
    case none
}
