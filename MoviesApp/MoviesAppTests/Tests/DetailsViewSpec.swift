//
//  DetailsViewSpec.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/19/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import Foundation
import Quick
import Nimble

@testable import MoviesApp

class DetailSpec: QuickSpec{
    
    override func spec() {
        let movie = MovieMock()
        let crud = CRUDMock()
        let viewModel = DetailsViewModel(crud: crud, movie: movie)
        let controller = DetailsController(crud: crud, selectedMovie: movie)
      
        describe("Create a presentable genres string") {
            it("has to present the genres in the movie"){
                expect(viewModel.detailsGenres()) == " Action, Adventure"
            }
        }
        
        describe("Check if is adding favorites") {
            it("has to call the function addFavorite"){
                viewModel.addFavorite()
                expect(crud.hasAddFavorite).to(beTrue())
                expect(crud.hasSavedData).to(beTrue())
            }
        }
        
        describe("Check if a movie is a favorite") {
            it("has to call the function checkFavorite"){
                viewModel.checkFavorite(movieID: movie.id)
                expect(crud.hasCheckedFav).to(beTrue())
            }
        }
        
        describe("Check if the view is loading") {
            it("view has to be equal to equal to the DetailView"){
                controller.viewDidLoad()
                expect(controller.view) == controller.screen
            }
        }
    }
}
