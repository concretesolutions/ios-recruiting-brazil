//
//  UITableView+Extension.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 09/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
}
