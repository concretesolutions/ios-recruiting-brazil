//
//  ListMoviesViewControllerSpec.swift
//  MovsTests
//
//  Created by Maisa on 31/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class ListMoviesViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Listing favorite movies") {
            context("when initializing") {
                // Initial configuration of the view
                var interactor: ListMoviesInteractorMock!
                var viewController: ListMoviesViewController!
                
                beforeEach {
                    interactor = ListMoviesInteractorMock()
                    viewController = ListMoviesViewController()
                    viewController.interactor = interactor
                }
                
                it("should fetch movies") {
//                    expect(interactor.fetchMovie(page: 1)).to(beTrue())
                }
                
                it("should present network error") {
//                    expect(interactor.fetchMovie(page: 0)).to(beTrue())
                }
            }
        }
    
    }
    
    
}
