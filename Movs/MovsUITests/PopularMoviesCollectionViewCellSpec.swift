//
//  PopularMoviesCollectionViewCellSpec.swift
//  MovsUITests
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class PopularMoviesCollectionViewCellSpec: QuickSpec {

    override func spec() {
        var popularMoviesCollectionViewCell: PopularMoviesCollectionViewCell!

        describe("PopularMoviesCollectionViewCell") {
            var frame: CGRect!
            var movieDTO: MovieDTO!
            var movie: Movie!
            var viewModel: PopularMoviesCellViewModel!
            beforeEach {
                frame = CGRect(x: 0, y: 0, width: 250, height: 375)
                movieDTO = MovieDTO(id: 1,
                                    overview: "",
                                    releaseDate: "",
                                    genreIds: [1, 2, 3],
                                    title: "Star Wars: The Rise of Skywalker",
                                    posterPath: nil)
                movie = Movie(withMovie: movieDTO)
                viewModel = PopularMoviesCellViewModel(withMovie: movie)
            }
            
            context("loaded") {
                context("when ins't liked") {
                    beforeEach {
                        viewModel.isLiked = false
                        popularMoviesCollectionViewCell = PopularMoviesCollectionViewCell(frame: frame)
                        popularMoviesCollectionViewCell.setViewModel(viewModel)
                        
                    }
                    
                    it("should have the expected look and feel.") {
                        expect(popularMoviesCollectionViewCell) == snapshot("PopularMoviesCollectionViewCell")
                    }
                }
                
                context("when is liked") {
                    beforeEach {
                        viewModel.isLiked = true
                        popularMoviesCollectionViewCell = PopularMoviesCollectionViewCell(frame: frame)
                        popularMoviesCollectionViewCell.setViewModel(viewModel)
                    }
                    
                    it("should have the expected look and feel.") {
                        expect(popularMoviesCollectionViewCell) == snapshot("PopularMoviesCollectionViewCell_liked")
                    }
                }
            }
        }
    }

}
