//
//  BaseTabViewController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

protocol BaseTabViewController: UIViewController {
    var tabBarTitle: String { get }
    var tabBarImage: UIImage { get }
    var tabBarImageSelected: UIImage { get }

    func setupTab()
}

extension BaseTabViewController {

    func setupTab() {
        let unselectedColor = UIColor(asset: .darkerBrand)

        self.tabBarItem = UITabBarItem(
            title: self.tabBarTitle,
            image: self.tabBarImage.mask(with: unselectedColor)!
                .withRenderingMode(.alwaysOriginal),
            selectedImage: self.tabBarImageSelected

        )

        self.tabBarItem.setTitleTextAttributes(
            [.foregroundColor: UIColor.black],
            for: .selected
        )

        self.tabBarItem.setTitleTextAttributes(
            [.foregroundColor: unselectedColor],
            for: .normal
        )
    }
}
