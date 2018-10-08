//
//  MovieDetailPresenter.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieDetailPresenter {
    private weak var viewProtocol: MovieDetailViewProtocol?
    private lazy var client = MovieDetailClient()
    
    init(with view: MovieDetailViewProtocol) {
        viewProtocol = view
    }
}

//MARK: - Protocol methods -
extension MovieDetailPresenter: MoviePresenterProtocol {
    func getGenreList() {
        guard let model = viewProtocol?.model else { return }
        viewProtocol?.showGenreLoading()
        client.getGenreList(with: model.genreIds) { [weak self] result in
            self?.viewProtocol?.hideGenreLoading()
            switch result {
            case let .success(genreList):
                self?.viewProtocol?.setGenreText(with: self?.makeGenreString(with: genreList, and: model.genreIds))
            case .fail(_):
                break
            }
        }
    }
    
    private func makeGenreString(with genreList: GenreListModel, and movieGenresIds: [Int]) -> String {
        var string = ""
        movieGenresIds.forEach { id in
            if let genre = genreList.genres.first(where: { $0.id == id }) {
                string.append("\(genre.name), ")
            }
        }
        
        string.removeLast(2)
        return string
    }
}
