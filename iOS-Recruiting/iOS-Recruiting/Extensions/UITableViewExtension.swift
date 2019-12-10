//
//  UITableViewExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        
        return cell
    }

    func dequeue<T: UITableViewCell>() -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        
        return cell
    }

}
