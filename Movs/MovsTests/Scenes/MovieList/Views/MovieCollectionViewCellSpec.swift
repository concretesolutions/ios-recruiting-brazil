//
//  MovieCollectionViewCellSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 29/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class MovieCollectionViewCellSpec: QuickSpec {
    
    let title = "Movie"
    let posterURL = "https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png"
    
    override func spec() {
        describe("MovieCollectionViewCell Spec") {
            it("init with frame") {
                let cell = MovieCollectionViewCell(frame: .zero)
                expect(cell.imageView.image).to(beNil())
                expect(cell.title.text).toNot(beNil())
                expect(cell.favoriteButton.imageView).toNot(beNil())
                expect(cell.didPressButton).to(beNil())
            }
            
            it("init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                expect(MovieCollectionViewCell(coder: archiver)).to(raiseException())
            }
            
            it("set with empty movie") {
                let movie = MovieList.ViewModel.Movie(title: "", posterURL: "", favoriteImageName: "")
                let cell = MovieCollectionViewCell(frame: .zero)
                cell.set(movie: movie)
                expect(cell.imageView.image).to(beNil())
                expect(cell.title.text).toNot(beNil())
                expect(cell.favoriteButton.imageView?.image).toNot(beNil())
            }
            
            it("set movie with only title") {
                let movie = MovieList.ViewModel.Movie(title: self.title, posterURL: "", favoriteImageName: "")
                let cell = MovieCollectionViewCell(frame: .zero)
                cell.set(movie: movie)
                expect(cell.imageView.image).to(beNil())
                expect(cell.title.text).toNot(beNil())
                expect(cell.favoriteButton.imageView?.image).toNot(beNil())
            }
            
            it("set movie with only posterURL") {
                let movie = MovieList.ViewModel.Movie(title: "", posterURL: self.posterURL, favoriteImageName: "")
                let cell = MovieCollectionViewCell(frame: .zero)
                cell.set(movie: movie)
                expect(cell.imageView.image).toEventuallyNot(beNil())
                expect(cell.title.text).toNot(beNil())
                expect(cell.favoriteButton.imageView?.image).toNot(beNil())
            }
            
            it("set movie with only favoriteImage") {
                let movie = MovieList.ViewModel.Movie(title: "", posterURL: "", favoriteImageName: Constants.ImageName.favoriteGray)
                let cell = MovieCollectionViewCell(frame: .zero)
                cell.set(movie: movie)
                expect(cell.imageView.image).to(beNil())
                expect(cell.title.text).toNot(beNil())
                expect(cell.favoriteButton.imageView?.image).toNot(beNil())
            }
            
            it("set with movie") {
                let movie = MovieList.ViewModel.Movie(title: self.title, posterURL: self.posterURL, favoriteImageName: Constants.ImageName.favoriteGray)
                let cell = MovieCollectionViewCell(frame: .zero)
                cell.set(movie: movie)
                expect(cell.imageView.image).toEventuallyNot(beNil())
                expect(cell.title.text?.contains(self.title)).to(beTrue())
                expect(cell.favoriteButton.imageView?.image).toNot(beNil())
            }
            
        }
    }
}

