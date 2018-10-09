//
//  MovieDetailPresenter.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 07/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation
import UIKit

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
                self?.viewProtocol?.setGenreText(with: "Ocorreu um erro ao baixar a lista de generos do filme.")
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
    
    func setFavorite() {
        guard let model = viewProtocol?.model else { return }
        changeFavsList(with: model)
    }
    
    private func setButtonState(with isFav: Bool) {
        if isFav {
            viewProtocol?.setFavEnable()
        } else {
            viewProtocol?.setFavDisable()
        }
    }
    
    private func changeFavsList(with model: MovieDetailModel) {
        if model.isFav {
            removeFromList(model)
        } else {
            saveInList(model)
        }
    }
    
    private func saveInList(_ model: MovieDetailModel) {
        let didSave = client.saveModelInFavsList(with: model)
        if didSave {
            setButtonState(with: model.isFav)
        }
    }
    
    private func removeFromList(_ model: MovieDetailModel) {
        let didRemove = client.removeModelInFavsList(with: model)
        if didRemove {
            setButtonState(with: model.isFav)
        }
    }
    
    func setupFavoriteState() {
        guard
            let list = client.getfavList(),
            let model = viewProtocol?.model
            else { return }
        
        let isFav = list.contains(model)
        
        model.isFav = isFav
        setButtonState(with: model.isFav)
    }
}
