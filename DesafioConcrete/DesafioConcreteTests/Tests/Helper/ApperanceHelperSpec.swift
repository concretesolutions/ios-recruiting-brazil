//
//  ApperanceHelperSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class ApperanceHelperSpec: XCTestCase {

    func testNavigationBarAppearance() {
        ApperanceHelper.customizeNavigationBar()
        let navigationBar = UINavigationBar.appearance()
        XCTAssertTrue(navigationBar.tintColor == CustomColor.black)
        XCTAssertTrue(navigationBar.barTintColor == CustomColor.yellow)
    }
    
    func testTabBarAppearance() {
        ApperanceHelper.customizeTabBar()
        let tabBarAppearace = UITabBar.appearance()
        XCTAssertTrue(tabBarAppearace.tintColor == CustomColor.black)
        XCTAssertTrue(tabBarAppearace.unselectedItemTintColor == CustomColor.gray)
        XCTAssertTrue(tabBarAppearace.barTintColor == CustomColor.yellow)
    }
}
