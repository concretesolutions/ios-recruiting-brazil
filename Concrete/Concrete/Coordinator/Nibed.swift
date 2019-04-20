//
//  Nibed.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

protocol Nibed {
    static func instantiate() -> Self
}

extension Nibed where Self: UIViewController {
    
    static func instantiate() -> Self {
        let idx = String(describing: self)
        return Self(nibName: idx, bundle: .main)
    }
}
