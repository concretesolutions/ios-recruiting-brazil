//
//  MoviesGridViewTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift
@testable import TheMovies

class MoviesGridViewTests: QuickSpec {
    override func spec() {
        describe("MoviesGrid") {
            var controller: MoviesGridController!
            var presenterSpy: MoviesGridPresenterSpy!
            
            beforeEach {
                presenterSpy = MoviesGridPresenterSpy()
                controller = MoviesGridController(presenter: presenterSpy)
            }
            
            afterEach {
                controller = nil
                presenterSpy = nil
            }
            
            describe("View") {
                it("MoviesGridView Layout") {
                    let view = MoviesGridView(frame:  UIScreen.main.bounds)
                    view.didMoveToWindow()
                    
                    let dataSource = MoviesGridDatasourceMock(store: MovieStoreMock())
                    
                    view.collectionView.dataSource = dataSource
                    
                    expect(view) == snapshot("MoviesGridView")
//                    expect(view) == recordSnapshot("MoviesGridView")
                }
                
                it("MoviesGridCell - Layout") {
                    let view = MoviesGridCell(frame:  UIScreen.main.bounds)
                    view.didMoveToWindow()
                    
                    view.label.text = "Test"
                    
                    expect(view) == snapshot("MoviesGridCell")
//                    expect(view) == recordSnapshot("MoviesGridCell")
                }
            }
            
            describe("Controller") {
                it("Deve carregar gêneros") {
                    controller.loadView()
                    expect(presenterSpy.callCacheGenresCount) == 1
                }
                
                it("Deve carregar 10 páginas de filmes da API") {
                    controller.loadView()
                    expect(presenterSpy.callLoadNewPageMoviesFromNetworkCount) == 10
                }
                
                it("Deve recarregar com o que foi salvo em cache") {
                    controller.viewWillAppear(false)
                    expect(presenterSpy.callLoadMoviesFromCacheCount) == 1
                }
            }
        }
    }
}

