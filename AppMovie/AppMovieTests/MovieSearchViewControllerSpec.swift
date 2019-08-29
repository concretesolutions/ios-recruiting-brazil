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
@testable import AppMovie

class MovieSearchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieSearchViewController") {
            
            var sut: MovieSearchViewController!
            
            beforeEach {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tab = storyboard.instantiateInitialViewController() as! UITabBarController
                let nav = tab.viewControllers?[0] as! UINavigationController
                sut = nav.topViewController as? MovieSearchViewController
                print(sut)
                
                sut.service = MovieServiceMock()
                /*Metodo usando Injecao de Dependencia
                 sut.setupView(service: MovieServiceMock()) */
                
                _ = sut.view
                sut.beginAppearanceTransition(true, animated: false)
                //                sut.loadView()
                print(sut.movie.count)
                
            }
            
//            describe("configureViewComponents", {
//                
//            })
            
            it("should have a valid instance") {
                expect(sut).toNot(beNil())
            }
            
            it("should have the expected number of movies") {
                expect(sut.movie.count).to(equal(20))
            }
            
            describe("MoviesSearchViewController UI") {
                it("should have the expected calling ui") {
                    expect(sut.view) == recordSnapshot()
                } }
        }
    }
}
