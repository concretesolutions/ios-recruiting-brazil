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
            removeModelInFavsList(with: model)
        } else {
            saveModelInFavsList(with: model)
        }
    }
    
    private func removeModelInFavsList(with model: MovieDetailModel) {
        let userDefault = UserDefaultWrapper()
        model.isFav = false
        guard
            let favList = getfavList(),
            let index = favList.firstIndex(where: { $0 == model.id }),
            let _: [Int] = userDefault.deleteItem(in: index, with: userDefault.favsListKey)
        else {
            model.isFav = true
            return
        }
        
        setButtonState(with: model.isFav)
    }
    
    private func saveModelInFavsList(with model: MovieDetailModel) {
        model.isFav = true
        let userDefault = UserDefaultWrapper()
        userDefault.appendItem(model.id, with: userDefault.favsListKey)
        setButtonState(with: model.isFav)
    }
    
    func setupFavoriteState() {
        guard
            let list = getfavList(),
            let model = viewProtocol?.model
            else { return }
        
        let isFav = list.contains(model.id)
        
        model.isFav = isFav
        setButtonState(with: model.isFav)
    }
    
    private func getfavList() -> [Int]? {
        let userDefault = UserDefaultWrapper()
        let favList: [Int]? = userDefault.get(with: userDefault.favsListKey)
        return favList
    }
}
