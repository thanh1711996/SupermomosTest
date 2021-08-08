//
//  LoadingManager.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import Foundation
import UIKit

class LoadingManager {
    static var shared = LoadingManager()
    var loading: UIView?
    
    func showLoading() {
        guard let view = UIApplication.shared.windows.last else { return }
        
        let viewLoading = UIView(frame: view.frame)
        viewLoading.backgroundColor = .black.withAlphaComponent(0.4)
        
        let viewIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        viewIndicator.backgroundColor = .black
        viewIndicator.cornerRadius = 8
        viewIndicator.center = viewLoading.center
        
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.color = .white
        ai.startAnimating()
        ai.center = viewIndicator.center
        
        ai.embed(in: viewIndicator)
        viewLoading.addSubview(viewIndicator)
        
        DispatchQueue.main.async {
            viewLoading.embed(in: view)
        }
        
        loading = viewLoading
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loading?.removeFromSuperview()
            self.loading = nil
        }
    }
}
