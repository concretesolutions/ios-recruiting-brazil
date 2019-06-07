//
//  MovieDetailPresenter.swift
//  Cineasta
//
//  Created by Tomaz Correa on 05/06/19.
//  Copyright (c) 2019 TCS. All rights reserved.
//

import Foundation

// MARK: - VIEW DELEGATE -
protocol MovieDetailViewDelegate: NSObjectProtocol {
    func showLoadingGenre()
    func showGenre(genre: String)
}

// MARK: - PRESENTER CLASS -
class MovieDetailPresenter {
    
    private weak var viewDelegate: MovieDetailViewDelegate?
    private lazy var service = GenresService()
    private var genreIds = [Int]()
    
    init(viewDelegate: MovieDetailViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}

// MARK: - USERDEFAULTS -
extension MovieDetailPresenter {
    func getGenres(genreIds: [Int]) {
        self.genreIds = genreIds
        let result: GenresResult? = UserDefaulstHelper.shared.getObject(forKey: Constants.UserDefaultsKey.genres)
        guard let genresResult = result else { self.getGenresFromService(); return }
        self.showGenre(genresResult: genresResult)
    }
}

// MARK: - SERVICE -
extension MovieDetailPresenter {
    private func getGenresFromService() {
        self.viewDelegate?.showLoadingGenre()
        self.service.getGenres(errorCompletion: { [unowned self] (_) in
            self.viewDelegate?.showGenre(genre: "Não foi possível carregar o gênero =(")
            }, successCompletion: { [unowned self] (genresResult) in
                UserDefaulstHelper.shared.saveObject(object: genresResult, forKey: Constants.UserDefaultsKey.genres)
                self.showGenre(genresResult: genresResult)
        })
    }
}

// MARK: - AUX METHODS -
extension MovieDetailPresenter {
    private func showGenre(genresResult: GenresResult) {
        guard let genres = genresResult.genres?.filter({genreIds.contains($0.genreId ?? -1)}) else { return }
        let names = genres.map({$0.name ?? ""})
        let stringName = names.joined(separator: " | ").uppercased()
        self.viewDelegate?.showGenre(genre: stringName)
    }
}
