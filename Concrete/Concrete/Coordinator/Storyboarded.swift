//
//  Storyboarded.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let idx = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewC = storyboard.instantiateViewController(withIdentifier: idx) as? Self else {
            fatalError("failed to load \(idx) storyboard file.")
        }
        
        return viewC
    }
}
