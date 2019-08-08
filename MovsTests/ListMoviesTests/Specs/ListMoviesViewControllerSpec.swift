//
//  ListMoviesViewControllerSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class ListMoviesViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: ListMoviesViewController!
        var presenter: ListMoviesPresentationMock!
        var movies: [MovieEntity] = []
        var posters: [PosterEntity] = []
        
        beforeEach {
            sut = UIStoryboard(name: "ListMovies", bundle: nil).instantiateViewController(withIdentifier: "ListMovies") as? ListMoviesViewController
            presenter = ListMoviesPresentationMock()
            sut.presenter = presenter
            sut.view.didMoveToWindow()
            
            movies.append(MovieEntityMock.createMovieEntityInstance()!)
            posters.append(PosterEntity(poster: UIImage(named: "Icon-20.png")!))
    
//            sut.movieCollectionView.delegate = sut
//            sut.movieCollectionView.dataSource = sut
        }
        
        describe("View") {
            it("Has to show list movies view", closure: {
                sut.showMoviesList(movies)
                sut.updatePosters(posters)
                sut.movieCollectionView.reloadData()
                waitUntil(timeout: 2) { (done) in
                    expect(sut.view) == snapshot("ListMoviesView", usesDrawRect: false)
                    done()
                }
            })
            
            it("Has to show view with no content") {
                sut.showNoContentScreen(image: UIImage(named: "search_icon"), message: "No movies available")
                waitUntil(timeout: 2) { (done) in
                    expect(sut.view) == snapshot("ListMoviesViewWithNoContent", usesDrawRect: false)
                    done()
                }
            }
        }
        
    }
}
