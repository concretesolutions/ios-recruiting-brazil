//
//  MovieDetailViewControllerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieDetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailViewController Spec") {
            
            var viewController: MovieDetailViewController!
            
            context("init with decoder") {
                
                it("should raise expection") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(MovieDetailViewController(coder: archiver)).to(raiseException())
                }
            }
            
            context("init with movie not real") {
                
                var coreDataWorker: CoreDataWorker!
                
                beforeEach {
                    let movie = Movie(id: 0, genreIds: [],
                                      posterPath: "posterPath", overview: "overview",
                                      releaseDate: "yyyy-mm-dd", title: "title")
                    viewController = MovieDetailViewController(movie: movie)
                    coreDataWorker = CoreDataWorker()
                }
                
                it("should not be nil") {
                    expect(viewController).toNot(beNil())
                }
                
                it("should display move") {
                    let viewModel = MovieDetail.ViewModel(title: "", year: "",
                                                          genre: "", overview: "",
                                                          favoriteImage: UIImage(),
                                                          imageView: UIImageView())
                    viewController.display(viewModel: viewModel)
                    expect(viewController.imageView.image).to(beNil())
                    expect(viewController.textView.text).toNot(beNil())
                    expect(viewController.tableView.titleCell.button.imageView).toNot(beNil())
                    expect(viewController.tableView.titleCell.label.text).toNot(beNil())
                    expect(viewController.tableView.yearCell.label.text).toNot(beNil())
                    expect(viewController.tableView.genreCell.label.text).toNot(beNil())
                }
                
                it("should favorite the movie") {
                    let sender = UIButton()
                    viewController.pressedFavorite(sender: sender)
                    expect(coreDataWorker.isFavorite(id: 0)).to(beTrue())
                }
                
                it("should unfavorite the movie") {
                    let sender = UIButton()
                    viewController.pressedFavorite(sender: sender)
                    expect(coreDataWorker.isFavorite(id: 0)).to(beFalse())
                }
            }
            
            context("init with real movie") {
                
                beforeEach {
                    let movie = Movie(id: 335983, genreIds: [],
                                      posterPath: "", overview: "",
                                      releaseDate: "", title: "")
                    viewController = MovieDetailViewController(movie: movie)
                }
                
                it("should not be nil") {
                    expect(viewController).toNot(beNil())
                }
                
            }
        }
    }
}

