//
//  Extensions.swift
//  ActivityIndicatorExtension
//
//  Created by Renan Germano on 16/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

fileprivate let ACTIVITY_INDICATOR_ID = "indicatable_view"
fileprivate let ACTIVITY_INDICATOR_DEFAULT_TEXT = "Loading..."

extension UIViewController {
    
    func indicatableView() -> IndicatableView? {
        return (self.view.subviews.filter { $0.restorationIdentifier == ACTIVITY_INDICATOR_ID }).first as? IndicatableView
    }
    
    func isShowing() -> Bool {
        return self.indicatableView()?.isShowing ?? false
    }
    
}

extension UIViewController: Indicatable {
    
    func showActivityIndicator() {
        
        let indicatableView = IndicatableView(text: ACTIVITY_INDICATOR_DEFAULT_TEXT)
        
        indicatableView.backgroundColor = .clear
        indicatableView.restorationIdentifier = ACTIVITY_INDICATOR_ID
        self.view.addSubview(indicatableView)
        
        indicatableView.translatesAutoresizingMaskIntoConstraints = false
        indicatableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        indicatableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        indicatableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicatableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        indicatableView.showActivityIndicator()
    }
    
    func hideActivityIndicator() {
        if let indicatableView = indicatableView() {
            indicatableView.hideActivityIndicator()
            indicatableView.removeFromSuperview()
        }
    }
}

extension UIImageView {
    
    func indicatableView() -> IndicatableView? {
        return (self.subviews.filter { $0.restorationIdentifier == ACTIVITY_INDICATOR_ID }).first as? IndicatableView
    }
    
    func isShowing() -> Bool {
        return self.indicatableView()?.isShowing ?? false
    }
    
}

extension UIImageView: Indicatable {
    
    func showActivityIndicator() {
        
        let indicatableView = IndicatableView(text: ACTIVITY_INDICATOR_DEFAULT_TEXT)
        
        indicatableView.backgroundColor = .clear
        indicatableView.restorationIdentifier = ACTIVITY_INDICATOR_ID
        self.addSubview(indicatableView)
        
        indicatableView.translatesAutoresizingMaskIntoConstraints = false
        indicatableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        indicatableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        indicatableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicatableView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        indicatableView.showActivityIndicator()
    }
    
    func hideActivityIndicator() {
        if let indicatableView = indicatableView() {
            indicatableView.hideActivityIndicator()
            indicatableView.removeFromSuperview()
        }
    }
}
