//
//  MovieListViewControllerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 29/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class MovieListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MovieListViewController Spec") {
            var viewController: MovieListViewController!
            
            context("init with coder") {
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(MovieListViewController(coder: archiver)).to(raiseException())
                }
            }
            
            context("init with no nib") {
                beforeEach {
                    viewController = MovieListViewController(nibName: nil, bundle: nil)
                }
                
                it("should have collection view dataSource and delegate") {
                    expect(viewController.collectionView.dataSource).toNot(beNil())
                    expect(viewController.collectionView.delegate).toNot(beNil())
                }
                
                it("should have no movies and initial page") {
                    expect(viewController.data.movies.count).to(be(0))
                    expect(viewController.page).to(be(1))
                }
                
                it("should have router and interactor") {
                    expect(viewController.router).toNot(beNil())
                    expect(viewController.interactor).toNot(beNil())
                }
                
                it("should not have any errors") {
                    expect(viewController.viewError).to(beNil())
                }
                
                it("should have title and tabBarItem") {
                    expect(viewController.title).to(equal("Movies"))
                    expect(viewController.tabBarItem).toNot(beNil())
                }
                
                it("should have state machine and displayState") {
                    expect(viewController.stateMachine).toNot(beNil())
                    expect(viewController.stateMachine.currentState).to(beAKindOf(MovieListDisplayState.self))
                }
                
                it("should fetch movies and increment pages") {
                    let page = viewController.page
                    let moviesCount = viewController.data.movies.count
                    viewController.fetchMoreMovies()
                    expect(viewController.page).toEventually(beGreaterThan(page))
                    expect(viewController.data.movies.count).toEventually(beGreaterThan(moviesCount))
                }
                
                context("states hide and show vies") {
                    it("should show collectionView and hide error when in displayState") {
                        _ = viewController.stateMachine.enter(MovieListErrorState.self)
                        expect(viewController.collectionView.isHidden).to(beFalse())
                        expect(viewController.errorView.isHidden).to(beTrue())
                    }
                    
                    it("should hide collectionView and display error when in errorState") {
                        _ = viewController.stateMachine.enter(MovieListDisplayState.self)
                        expect(viewController.collectionView.isHidden).to(beFalse())
                        expect(viewController.errorView.isHidden).to(beTrue())
                    }
                    
                    it("should hide collectionView and display error when in loadingState") {
                        _ = viewController.stateMachine.enter(MovieListLoadingState.self)
                        expect(viewController.collectionView.isHidden).to(beFalse())
                        expect(viewController.errorView.isHidden).to(beTrue())
                    }
                }
                
                context("change states by methods") {
                    
                    it("should be in display state when displaying movies") {
                        let success = MovieListModel.ViewModel.Success(movies: [])
                        viewController.displayMovies(viewModel: success)
                        expect(viewController.stateMachine.currentState).to(beAKindOf(MovieListDisplayState.self))
                    }
                    
                    it("should be in display state when filtering movies") {
                        viewController.filterMovies(named: "")
                        expect(viewController.stateMachine.currentState).toEventually(beAKindOf(MovieListDisplayState.self))
                    }
                    
                    it("should be in error state when error occurs") {
                        let error = MovieListModel.ViewModel.Error(error: "")
                        viewController.displayError(viewModel: error)
                        expect(viewController.stateMachine.currentState).to(beAKindOf(MovieListErrorState.self))
                    }
                    
                    it("should be in error state when not find a search") {
                        let error = MovieListModel.ViewModel.Error(error: "")
                        viewController.displayNotFind(viewModel: error)
                        expect(viewController.stateMachine.currentState).to(beAKindOf(MovieListErrorState.self))
                    }
                    
                    it("should be in loading state when fetching movies") {
                        viewController.fetchMoreMovies()
                        expect(viewController.stateMachine.currentState).toEventually(beAKindOf(MovieListLoadingState.self))
                    }
                    
                }
                
            }
            
        }
    }
}

