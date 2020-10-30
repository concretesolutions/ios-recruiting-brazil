//
//  UIViewController+Extension.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc func setupNavigationBar() {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .appYellowLight
        navigationItem.standardAppearance = navigationAppearance
        navigationItem.scrollEdgeAppearance = navigationAppearance
    }
}
