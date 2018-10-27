//
//  UIView+Autolayout.swift
//  Movs
//
//  Created by Gabriel Reynoso on 27/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillAvailableSpaceInSuperview() {
        guard let parent = self.superview else { return }
        self.fillAvailableSpace(using: parent.layoutMarginsGuide)
    }
    
    func fillAvailableSpaceInSafeArea() {
        guard let parent = self.superview else { return }
        self.fillAvailableSpace(using: parent.safeAreaLayoutGuide)
    }
    
    private func fillAvailableSpace(using layoutGuide: UILayoutGuide) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
    }
}
