//
//  UIView+Helpers.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

extension UIView {
    func fillToSuperview(safeArea: Bool = true) {
        guard let superView = superview else { return }

        if safeArea {
            anchor(top: superView.safeAreaLayoutGuide.topAnchor)
            anchor(leading: superView.safeAreaLayoutGuide.leadingAnchor)
            anchor(trailing: superView.safeAreaLayoutGuide.trailingAnchor)
            anchor(bottom: superView.safeAreaLayoutGuide.bottomAnchor)
        } else {
            anchor(top: superView.topAnchor)
            anchor(leading: superView.leadingAnchor)
            anchor(trailing: superView.trailingAnchor)
            anchor(bottom: superView.bottomAnchor)
        }
    }
}
