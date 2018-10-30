//
//  FavoritesListVCMOdel.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

final class FavoritesListVCModel: NSObject {
	private let filterUseCase: Domain.FilterUseCase
	private let favoriteMoviesUseCase: Domain.FavoriteMoviesUseCase
	
	public var baseFilter: Filter?
	private var movies: [Movie]
	
	public var filter: Filter?
	private var searchMovies: [Movie]
	
	weak var searchBar: UISearchBar?
	weak var tableView: UITableView?
	
	var pushToDetail : ((Movie, Bool) -> ())?
	
	init(filterUseCase: Domain.FilterUseCase, favoriteMoviesUseCase: Domain.FavoriteMoviesUseCase, movies: [Movie] = []) {
		self.filterUseCase = filterUseCase
		self.favoriteMoviesUseCase = favoriteMoviesUseCase
		self.movies = movies
		self.searchMovies = []
	}
	
	private func set(filter: Filter?, on baseMovies: [Movie]) -> [Movie]{
		if let uFilter = filter {
			let filteredMovies = baseMovies.filter({ (movie) -> Bool in
				return (uFilter.yearOfReleases.isEmpty || uFilter.yearOfReleases.contains( movie.yearOfRelease ?? Date.invalidYear ))
					&& (uFilter.genreIDs().isEmpty || uFilter.genreIDs().filter({ movie.genreIDs.contains( $0 ) }).count != 0)
			})
			return filteredMovies
		} else {
			return baseMovies
		}
	}
	
	public func reloadTableView(){
		fetchFavoriteMovies { (fetchedMovies) in
			self.filterFrom(movies: fetchedMovies, handler: { (baseFilter) in
				self.baseFilter = baseFilter
				self.movies = self.set(filter: self.filter, on: fetchedMovies)
				self.tableView?.reloadData()
			})
		}
	}
	
	private func fetchFavoriteMovies(handler: @escaping ([Movie]) ->() ){
		favoriteMoviesUseCase.fetchFavorites { (movies, error) in
			if let movies = movies {
				handler(movies)
			} else {
				handler([])
			}
		}
	}
	
	private func genresIDsOf(movies: [Movie]) -> [Int]{
		var genresIDs = Set<Int>()
		movies.forEach({ $0.genreIDs.forEach({ genresIDs.insert( $0 ) }) })
		return Array(genresIDs)
	}
	
	private func yearOfReleasesOf(movies: [Movie]) -> [Int]{
		var yearOfReleases = Set<Int>()
		movies.forEach({ yearOfReleases.insert( $0.yearOfRelease ?? Date.invalidYear ) })
		return Array(yearOfReleases)
	}
	
	private func filterFrom(movies: [Movie], handler: @escaping (_ filter: Filter) -> ()){
		var genresIDs = Set<Int>()
		var yearOfReleases = Set<Int>()
		
		movies.forEach({
			$0.genreIDs.forEach({ genresIDs.insert( $0 ) })
			yearOfReleases.insert($0.yearOfRelease ?? Date.invalidYear)
		})
		
		fetchCachedGenres(with: Array(genresIDs)) { (genres) in
			handler(Filter(genres: genres, yearOfReleases: Array(yearOfReleases)) )
		}

	}
	
	private func fetchCachedGenres(with IDs: [Int], handler: @escaping ([Genre])->()){
		filterUseCase.fetchCachedGenres(with: IDs) { (genres, error) in
			if let genres = genres {
				handler(genres)
			} else {
				handler([])
			}
		}
	}
	
	private func onFilterMode() -> Bool {
		return (filter != nil)
	}
	
	private func onSearchMode() -> Bool {
		return (searchBar?.text != "")
	}
}

extension FavoritesListVCModel {
	public func registerSearchBar(view: UISearchBar){
		self.searchBar = view
	}
	
	public func registerSearchBarDelegate() -> UISearchBarDelegate {
		return self
	}
	
	public func registerTable(view: UITableView){
		self.tableView = view
	}
	
	public func registerTableViewDelegate() -> UITableViewDelegate {
		return self
	}
	
	public func registerTableViewDataSource() -> UITableViewDataSource {
		return self
	}
}

extension FavoritesListVCModel {
	func detailFavorite(movie: Movie, favorite: Bool) {
		pushToDetail?(movie, favorite)
	}
}

extension FavoritesListVCModel: UITableViewDelegate, UITableViewDataSource {
	internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (onSearchMode() ? searchMovies.count : movies.count)
	}
	
	internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell {
			
			let item = onSearchMode() ? searchMovies[indexPath.row] : movies[indexPath.row]
			
			let entity = MovieCellEntity(title: item.title,
										 year: item.yearDescription,
										 bannerURL: item.backdropImageURL())
			
			cell.setup(entityModel: entity)
			
			return cell
		} else {
			return UITableViewCell(frame: .zero)
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let movie = onSearchMode() ? searchMovies[indexPath.row] : movies[indexPath.row]
		tableView.deselectRow(at: indexPath, animated: true)
		detailFavorite(movie: movie, favorite: true)
	}
	
	internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return UITableViewCell.EditingStyle.delete
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if (editingStyle == .delete){
			let movie = onSearchMode() ? searchMovies[indexPath.row] : movies[indexPath.row]
			_ = onSearchMode() ? searchMovies.remove(at: indexPath.row) : movies.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			favoriteMoviesUseCase.deleteFavorite(object: movie)
			reloadTableView()
		}
	}
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "Desfavoritar"
	}
}

extension FavoritesListVCModel: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		var matchingMovies: [Movie] = []
		movies.forEach({
			let searchBase = "\($0.title) \($0.yearDescription)".uppercased()
			if searchBase.contains(searchText.uppercased()){
				matchingMovies.append($0)
			}
		})
		
		self.searchMovies = matchingMovies
		self.tableView?.reloadData()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.enablesReturnKeyAutomatically = false
	}
}
