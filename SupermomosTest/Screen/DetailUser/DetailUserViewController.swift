//
//  DetailUserViewController.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import UIKit

class DetailUserViewController: BaseViewController, BaseViewControllerProtocol {
    
    // outlet element xib
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblFollower: UILabel!
    @IBOutlet weak var lblFollwing: UILabel!
    @IBOutlet weak var lblRepo: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    
    // init view model
    private(set) var viewModel: DetailUserViewModel!
    
    init(id: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel = DetailUserViewModel(id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }

    // setup ui
    func setupUI() {
        setupView()
    }
    
    // setup MVVM
    func bindViewModel() {
        bindModelChange()
    }
    
    func viewInReady() {
        viewModel.viewInReady()
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        popToViewController()
    }
    
    override func didPullToRefresh() {
        super.didPullToRefresh()
        self.viewModel.refreshUser()
    }
}

// MARK: setup view
extension DetailUserViewController {
    func setupView() {
        imgBackground.image = viewModel.imageBackground
        addPullToRefresh(scrollView: scrollView, color: .white)
    }
    
    func setDataView(_ user: UserModel) {
        if let avatarData = user.avatarData {
            imgAvatar.image = UIImage(data: avatarData)
        } else {
            imgAvatar.setImage(from: user.avatarUrl) { image,_,_,_  in
                let user = user
                user.avatarData = image?.pngData()
                RealmManager.shared.addUsersObject(object: [UserObject(userModel: user)])
            }
        }
        
        lblName.text = user.name
        lblFollower.text = String(user.followers)
        lblFollwing.text = String(user.following)
        lblRepo.text = String(user.publicRepos)
        
        lblLocation.text = user.location
        lblLocation.isHidden = user.location?.isEmpty ?? true
        
        let isEmptyBio = user.bio?.isEmpty ?? true
        lblBio.text = isEmptyBio ? "User bio here" : user.bio
        lblBio.alpha = isEmptyBio ? 0.5 : 1
    }
}

// MARK: bind data MVVM
extension DetailUserViewController {
    func bindModelChange() {
        viewModel.modelChange.asObservable()
            .subscribe(onNext: { [unowned self] type in
                switch type {
                case .loaderStart:
                    LoadingManager.shared.showLoading()
                    break
                case .loaderEnd:
                    LoadingManager.shared.hideLoading()
                    break
                case .updateDataModel(let data):
                    LoadingManager.shared.hideLoading()
                    if let user = data as? UserModel {
                        setDataView(user)
                    }
                    break
                case .error(let message):
                    LoadingManager.shared.hideLoading()
                    showAlert(message: message)
                    break
                default:
                    break
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
}

