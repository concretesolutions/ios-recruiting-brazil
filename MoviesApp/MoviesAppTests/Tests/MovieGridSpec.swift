//
//  MovieGridSpec.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/16/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class MovieGridSpec: QuickSpec{
    
    override func spec() {
        let crudMock = CRUDMock()
        let apiMock = APIClientMock()
        let viewModel = MovieGridViewModel(crud: crudMock,apiAccess: apiMock)
        let controller = MovieGridController(crud: crudMock, apiAccess: apiMock)
      
        describe("Check if a movie is favorite") {
            it("has to be equal to true"){
                let movie = MovieMock()
                viewModel.movies.append(movie)
                expect(viewModel.checkFavorite(movieID: viewModel.movies[0].id)).to(beTrue())
            }
        }
        
        describe("Check if is loading the movies") {
            it("has to call the function"){
                viewModel.loadMovies()
                expect(apiMock.hasFetchedData).to(beTrue())
            }
        }
        
        describe("Check if the view is loading") {
            it("view has to be equal to equal to the MovieGridView"){
               controller.viewDidLoad()
               expect(controller.view) == controller.screen
            }
        }
    }
    
}
