//
//  TabBarControllerSpec.swift
//  MovsTests
//
//  Created by Lucca França Gomes Ferreira on 19/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class TabBarControllerSpec: QuickSpec {
    
    override func spec() {
        describe("TabBarController") {
            context("initialized") {
                var tabBarController: TabBarController!
                beforeEach {
                    tabBarController = TabBarController()
                }
                it("contains two viewControllers") {
                    expect(tabBarController.viewControllers?.count).to(equal(2))
                }
                context("the first view controller") {
                    var navigationViewController: UINavigationController!
                    beforeEach {
                        navigationViewController = tabBarController.viewControllers?[0] as? UINavigationController
                    }
                    it("is a UINavigationViewController") {
                        expect(tabBarController.viewControllers?[0]).to(beAnInstanceOf(UINavigationController.self))
                    }
                    it("has PopularMoviesViewController on root") {
                        expect(navigationViewController.topViewController).to(beAnInstanceOf(PopularMoviesViewController.self))
                    }
                }
                context("the second view controller") {
                    var navigationViewController: UINavigationController!
                    beforeEach {
                        navigationViewController = tabBarController.viewControllers?[1] as? UINavigationController
                    }
                    it("is a UINavigationViewController") {
                        expect(tabBarController.viewControllers?[1]).to(beAnInstanceOf(UINavigationController.self))
                    }
                    it("has FavoriteMoviesViewController on root") {
                        expect(navigationViewController.topViewController).to(beAnInstanceOf(FavoriteMoviesViewController.self))
                    }
                }

            }
        }
    }

}
