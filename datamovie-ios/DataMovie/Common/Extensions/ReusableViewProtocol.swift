//
//  ReusableViewProtocol.swift
//  TheVargo
//
//  Created by Andre on 13/07/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return identifier
    }
    
}

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return identifier
    }
    
}
