//
//  NibLoadableProtocol.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var nibName: String { get }
    
    static func loadFromNib() -> Self
}

extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static func loadFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

protocol StoryboardLoadable {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
    
    static func loadFromStoryboard() -> Self
}

extension StoryboardLoadable {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: self.storyboardIdentifier) as? Self else {
            fatalError("The view controller \(self.storyboardIdentifier) expected its root view to be of type \(self)")
        }
        return viewController
    }
}
