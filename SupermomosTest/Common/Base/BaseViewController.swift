//
//  BaseViewController.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import Foundation
import UIKit

// protocol
protocol BaseViewControllerProtocol {
    func setupUI()
    func bindViewModel()
    func viewInReady()
}

// setup MVVM
extension BaseViewControllerProtocol where Self: UIViewController {
    func setupViewController() {
        setupUI()
        bindViewModel()
        viewInReady()
    }
}

public class BaseViewController: UIViewController {
    
    var refreshControl: UIRefreshControl!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addPullToRefresh(scrollView: UIScrollView, color: UIColor = .lightGray) {
        
        scrollView.alwaysBounceVertical = true
        scrollView.bounces  = true
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = color
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    @objc func didPullToRefresh() {
        refreshControl?.endRefreshing()
    }
}

// MARK: alert message
extension BaseViewController {
    func showAlert(title: String = "", message: String,
                   style: UIAlertController.Style = .alert,
                   saveCallBack: (() -> Void)? = nil,
                   closeCallBack: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let saveCallBack = saveCallBack {
            let action = UIAlertAction(title: "OK", style: .default, handler: { _ in saveCallBack() })
            alert.addAction(action)
        }
        
        if let closeCallBack = closeCallBack {
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in closeCallBack() })
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
        
        if saveCallBack == nil && closeCallBack == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: navigation
extension BaseViewController {
    func pushToViewController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popToViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}
