//
//  TabBarViewControllerDelegate.swift
//  Movs
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol TabBarViewControllerDelegate: AnyObject {
    func filterIconTapped(_ viewController: TabBarViewController)
    func filterSearchTapped(filter: FilterSearch, _ viewController: TabBarViewController)
}
