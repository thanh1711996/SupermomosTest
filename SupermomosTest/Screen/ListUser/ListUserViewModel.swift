//
//  ListUserViewModel.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ListUserViewModel {
    
    // init DisposeBag
    let disposeBag: DisposeBag
    
    let service = UserService()
    
    // event model change
    var modelChange = BehaviorRelay<BaseViewModelChange>(value: .none)
    
    private var usersModel: [UserModel] = []
    
    // init
    init() {
        disposeBag = DisposeBag()
    }
    
}

extension ListUserViewModel {
    // api get list user
    private func getApiListUser() {
        service.getListUser { [weak self] result in
            switch result {
            case .failure(let error):
                self?.modelChange.accept(.error(message: error.localizedDescription))
            case .success(let datas):
                self?.usersModel = datas
                self?.modelChange.accept(.loaderEnd)
                let usersObject = datas.map({ UserObject(userModel: $0)})
                RealmManager.shared.addUsersObject(object: usersObject)
            }
        }
    }
    
    // check offline
    private func getListUser() {
        if ApiManager.shared.networkAvailable {
            getApiListUser()
        } else {
            let users = RealmManager.shared.getUsersObject()
            self.usersModel = users.map({ UserModel(userObject: $0) })
            self.modelChange.accept(.loaderEnd)
        }
    }
    
    func viewInReady() {
        modelChange.accept(.loaderStart)
        getListUser()
    }
    
    func refreshListUser() {
        getListUser()
    }
    
    var numberCell: Int {
        return usersModel.count
    }
    
    func item(in index: Int) -> UserModel {
        return usersModel[index]
    }
}
