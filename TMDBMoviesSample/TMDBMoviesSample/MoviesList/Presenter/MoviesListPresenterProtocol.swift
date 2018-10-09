//
//  MoviesListPresenterProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MoviesListPresenterProtocol {
    var moviesLists: MoviesPages? { get }
    var filteredList: [MovieModel] { get }
    func filterList(with textFilter: String)
    func openMovieDetail(to indexPath: IndexPath, comeFromSearch: Bool)
    func getMovies()
    func getMoviePoster(to model: MovieModel, completion: @escaping (ResponseResultType<Data>, String) -> Void)
    func cancelTasks()
    func changeSearchCollectionState(shouldShowEmptySearch: Bool)
}
