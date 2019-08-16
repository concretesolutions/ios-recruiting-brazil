//
//  MovieSearchViewControllerSpec.swift
//  AppMovieTests
//
//  Created by ely.assumpcao.ndiaye on 16/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import XCTest
@testable import AppMovie

class MovieSearchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieSearchViewController") {
            
            var sut: MovieSearchViewController!
            
            beforeEach {
                
//                let tabBarController:UITabBarController = self.window?.rootViewController as! UITabBarController
//                let navBar = tabBarController.viewControllers?[0] as! UINavigationController
//                let controller = navBar.topViewController as! MovieSearchViewController
//                controller.setupView(service: MovieServiceImpl())
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tab = storyboard.instantiateInitialViewController() as! UITabBarController
                let nav = tab.viewControllers?[0] as! UINavigationController
                sut = nav.topViewController as! MovieSearchViewController
                
            
                print(sut)
                //  sut = nav.topViewController as! MovieSearchViewController
                // sut.service = MovieServiceMock()
                sut.setupView(service: MovieServiceMock())
                sut.api()
                print(sut.movie.count)
                _ = sut.view
                print(sut.movie.count)
                let test = MovieServiceMock()
                //print(test.moviesS)
                
                //_ = sut.view
            }
            
            it("should have a valid instance") {
                expect(sut).toNot(beNil())
            }
            
            it("should have the expected number of movies") {
                expect(sut.movie.count).to(equal(20))
            }
            
            describe("CharactersViewController UI") {
                it("should have the expected calling ui") {
                    expect(sut.view) == recordSnapshot()
                } }
        }
    }
}
