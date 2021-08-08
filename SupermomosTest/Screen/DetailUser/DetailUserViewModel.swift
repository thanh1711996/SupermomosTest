//
//  DetailUserViewModel.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

class DetailUserViewModel {
    
    // init DisposeBag
    let disposeBag: DisposeBag
    
    let service = UserService()
    
    // event model change
    var modelChange = BehaviorRelay<BaseViewModelChange>(value: .none)
    
    private var id: String
    private var userModel: UserModel?
    
    // init
    init(id: String) {
        self.id = id
        disposeBag = DisposeBag()
    }
    
    // random image background
    var imageBackground: UIImage? {
        let images = ["city1", "city2", "city3", "city4", "city5"]
        return UIImage(named: images.randomElement()!)
    }
}

extension DetailUserViewModel {
    private func getApiUser() {
        service.getUser(id: id) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.modelChange.accept(.error(message: error.localizedDescription))
            case .success(let data):
                self?.userModel = data
                self?.modelChange.accept(.updateDataModel(data: data))
                RealmManager.shared.addUsersObject(object: [UserObject(userModel: data)])
            }
        }
    }
    
    // check offline
    private func getUser() {
        if ApiManager.shared.networkAvailable {
            getApiUser()
        } else if let user = RealmManager.shared.getUserObject(id: id) {
            self.userModel = UserModel(userObject: user)
            self.modelChange.accept(.updateDataModel(data: self.userModel))
        } else {
            self.modelChange.accept(.updateDataModel(data: UserModel()))
        }
    }
    
    func viewInReady() {
        modelChange.accept(.loaderStart)
        getUser()
    }
    
    func refreshUser() {
        getUser()
    }
    
    
}

