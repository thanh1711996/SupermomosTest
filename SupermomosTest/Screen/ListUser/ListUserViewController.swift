//
//  ListUserViewController.swift
//  SupermomosTest
//
//  Created by Mac on 07/08/2021.
//

import UIKit

class ListUserViewController: BaseViewController, BaseViewControllerProtocol {

    // outlet element xib
    @IBOutlet weak var tableView: UITableView!
    
    // init view model
    private(set) var viewModel: ListUserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ListUserViewModel()
        setupViewController()
    }

    // setup ui
    func setupUI() {
        setupTableView()
    }
    
    // setup MVVM
    func bindViewModel() {
        bindModelChange()
    }
    
    func viewInReady() {
        viewModel.viewInReady()
    }
    
    override func didPullToRefresh() {
        super.didPullToRefresh()
        viewModel.refreshListUser()
    }
}

// MARK: setup view
extension ListUserViewController {
    func setupTableView() {
        tableView.registerCellNib(ListUserCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ListUserCell.rowHeight
        tableView.backgroundColor = .white
        addPullToRefresh(scrollView: tableView, color: .lightGray)
    }
}

// MARK: bind data MVVM
extension ListUserViewController {
    func bindModelChange() {
        viewModel.modelChange.asObservable()
            .subscribe(onNext: { [unowned self] type in
                switch type {
                case .loaderStart:
                    LoadingManager.shared.showLoading()
                    break
                case .loaderEnd:
                    LoadingManager.shared.hideLoading()
                    tableView.reloadData()
                    break
                case .updateDataModel(_):
                    break
                case .error(let message):
                    LoadingManager.shared.showLoading()
                    showAlert(message: message)
                    break
                default:
                    break
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
    
}

// MARK: handle push view controller
extension ListUserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ListUserCell.self)
        let data = viewModel.item(in: indexPath.row)
        cell.setupView(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.item(in: indexPath.row).login else { return }
        let vc = DetailUserViewController(id: id)
        self.pushToViewController(vc)
    }
    
}

