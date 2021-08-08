//
//  UITableview+Extension.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import Foundation
import UIKit

extension NSObject {

    @objc public class var name: String {
        get {
            return String(describing: self)
        }
    }
    
}

extension UIView {
    
    class func nib() -> UINib {
        return UINib(nibName: name, bundle: nil)
    }
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed( name, owner: nil, options: nil)![0] as! T
    }
    
}

extension UITableView {
    
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top,bottom
    }
}

extension UITableView {

    func registerCellNib<T: UITableViewCell>(_ type: T.Type) {
        register(type.nib(), forCellReuseIdentifier: type.name)
    }

    func registerCellClass<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.name)
    }

    func registerHeaderFooterNib<T: UIView>(for type: T.Type) {
        register(type.nib(), forHeaderFooterViewReuseIdentifier: type.name)
    }

    func registerHeaderFooterClass<T: UIView>(for type: T.Type) {
        register(type.self, forHeaderFooterViewReuseIdentifier: type.name)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: type.name) as! T
    }

    func dequeueReusableHeaderFooter<T: UIView>(_ type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: type.name) as? T
    }

    /// Scroll to bottom of TableView.
    ///
    /// - Parameter animated: set true to animate scroll (default is true).
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    /// Safely scroll to possibly invalid IndexPath
    ///
    /// - Parameters:
    ///   - indexPath: Target IndexPath to scroll to
    ///   - scrollPosition: Scroll position
    ///   - animated: Whether to animate or not
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}

