//
//  FavoritesTableViewCellSpec.swift
//  MovsUITests
//
//  Created by Lucca França Gomes Ferreira on 23/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class FavoritesTableViewCellSpec: QuickSpec {

    override func spec() {
        var favoritesTableViewCell: FavoritesTableViewCell!

        describe("FavoritesTableViewCell") {
            var frame: CGRect!
            var movieDTO: MovieDTO!
            var movie: Movie!
            var viewModel: FavoriteMoviesCellViewModel!
            beforeEach {
                frame = CGRect(x: 0, y: 0, width: 414, height: 250)
                movieDTO = MovieDTO(id: 1,
                                    overview: "The surviving Resistance faces the First Order once again as the journey of Rey, Finn and Poe Dameron continues. With the power and knowledge of generations behind them, the final battle begins.",
                                    releaseDate: "2019-12-18",
                                    genreIds: [1, 2, 3],
                                    title: "Star Wars: The Rise of Skywalker",
                                    posterPath: nil)
                movie = Movie(withMovie: movieDTO)
                viewModel = FavoriteMoviesCellViewModel(withMovie: movie)
            }
            
            context("loaded") {
                beforeEach {
                    favoritesTableViewCell = FavoritesTableViewCell(style: .default, reuseIdentifier: "favoritesTableViewCell")
                    favoritesTableViewCell.frame = frame
                    favoritesTableViewCell.setup(withViewModel: viewModel)
                }
                
                it("should have the expected look and feel.") {
                    expect(favoritesTableViewCell) == snapshot("FavoritesTableViewCell")
                }
            }
        }
    }
    
}
