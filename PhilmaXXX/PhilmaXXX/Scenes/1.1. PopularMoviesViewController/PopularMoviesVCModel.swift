//
//  PopularMoviesVCModel.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 22/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

final class PopularMoviesVCModel: NSObject {
	private let popularMoviesUseCase: Domain.PopularMoviesUseCase
	private let favoriteMoviesUseCase: Domain.FavoriteMoviesUseCase
	
	private var state: ApplicationState = .loading {
		didSet {
			changeApplication(state: state)
		}
	}

	private var movies: [Movie]
	private var searchMovies: [Movie]
	private var favoriteMoviesIDs: [Int]
	private var pageCount = 1
	
	var pushToDetail : ((Movie, Bool) -> ())?
	
	weak var errorView: PopularMoviesErrorView?
	weak var errorNoResults: PopularMoviesErrorView?
	weak var activityIndicator: UIActivityIndicatorView?
	weak var collectionView: UICollectionView?
	weak var searchBar: UISearchBar?
	
	func startApplication(){
		state = .loading
	}
	
	init(popularMoviesUseCase: Domain.PopularMoviesUseCase, favoriteMoviesUseCase: Domain.FavoriteMoviesUseCase, movies: [Movie] = [], favoriteMoviesIDs: [Int] = []) {
		self.popularMoviesUseCase = popularMoviesUseCase
		self.favoriteMoviesUseCase = favoriteMoviesUseCase
		self.movies = movies
		self.favoriteMoviesIDs = favoriteMoviesIDs
		self.searchMovies = []
	}
	
	private func fetchMovies(handler: @escaping (Bool) -> ()){
		popularMoviesUseCase.fetchMovies(pageNumber: pageCount) { (movies, error) in
			if let movies = movies {
				self.pageCount += 1
				self.movies.append(contentsOf: movies)
				self.refreshFavoriteMovies()
				handler(true)
			} else if let uError = error{
				print(uError.localizedDescription)
				handler(false)
			}
		}
	}
	
	public func refreshFavoriteMovies(){
		favoriteMoviesUseCase.fetchFavorites(handler: { (favMovies, error) in
			if let favMovies = favMovies {
				self.favoriteMoviesIDs = favMovies.map({ $0.id })
				self.collectionView?.reloadData()
			} else {
				print(error?.localizedDescription ?? "")
			}
		})
	}
	
	private func onSearchMode() -> Bool {
		return (searchBar?.text != "")
	}
}

extension PopularMoviesVCModel {
	public func registerGridDataSource() -> UICollectionViewDataSource {
		return self
	}
	
	public func registerGridDelegate() -> UICollectionViewDelegateFlowLayout {
		return self
	}
	
	public func registerGrid(collectionView: UICollectionView){
		self.collectionView = collectionView
	}
	
	public func registerSearchBar(view: UISearchBar){
		self.searchBar = view
	}
	
	public func registerSearchBarDelegate() -> UISearchBarDelegate {
		return self
	}
	
	public func registerErrorFatal(view: PopularMoviesErrorView) {
		errorView = view
	}
	
	public func registerErrorNoResults(view: PopularMoviesErrorView) {
		errorNoResults = view
	}
	
	public func registerActivityIndicator(view: UIActivityIndicatorView){
		activityIndicator = view
	}
}


// USE CASE INTERACTOR
extension PopularMoviesVCModel {
	func detailFavorite(movie: Movie, favorite: Bool) {
		pushToDetail?(movie, favorite)
	}
	
	func addFavorite(movie: Movie) {
		favoriteMoviesUseCase.addFavorite(object: movie)
		self.favoriteMoviesIDs.append(movie.id)
	}
	
	func deleteFavorite(movie: Movie) {
		favoriteMoviesUseCase.deleteFavorite(object: movie)
		self.favoriteMoviesIDs.removeAll(where: { $0 == movie.id })
	}
}

extension PopularMoviesVCModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return (onSearchMode() ? searchMovies.count : movies.count)
	}
	
	internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCollectionViewCell", for: indexPath) as? MoviePosterCollectionViewCell {
			
			let item = onSearchMode() ? searchMovies[indexPath.row] : movies[indexPath.row]
			
			let title = item.title
			let posterURL = item.posterImageURL()
			let stateFavorite = favoriteMoviesIDs.contains(item.id)
			
			let model = MoviePosterCellEntity(title: title, posterURL: posterURL, stateFavorite: stateFavorite)
			cell.setup(entityModel: model)
			
			cell.favoriteButtonAction = { flag in
				self.setFavorite(movie: item, flag: flag)
			}
			cell.backgroundColor = .black
			
			return cell
		} else {
			return UICollectionViewCell(frame: .zero)
		}
	}
	
	internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCollectionViewCell", for: indexPath) as? MoviePosterCollectionViewCell {
			let cvWidth = collectionView.frame.size.width
			return cell.cellSize(width: (cvWidth*0.4))
			
		}
		return CGSize.zero
	}
	
	internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if !onSearchMode(){
			let scrollPosition = (scrollView.contentOffset.y + ScreenSize.height())
			
			if (scrollPosition >= scrollView.contentSize.height * 0.5) {
				fetchMovies { (success) -> () in
				}
			}
		}
	}
	
	internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let movie = (onSearchMode() ? searchMovies[indexPath.row] : movies[indexPath.row] )
		self.detailFavorite(movie: movie, favorite: favoriteMoviesIDs.contains(movie.id))
	}
	
	
	func setFavorite(movie: Movie, flag: Bool){
		if flag == true {
			self.addFavorite(movie: movie)
		} else {
			self.deleteFavorite(movie: movie)
		}
	}
	
}

extension PopularMoviesVCModel: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		var matchingMovies: [Movie] = []
		movies.forEach({
			let searchBase = "\($0.title) \($0.yearOfRelease)".uppercased()
			if searchBase.contains(searchText.uppercased()){
				matchingMovies.append($0)
			}
		})
		
		if matchingMovies.count == 0 && onSearchMode(){
			self.state = .errorSearchNotFound
		} else {
			self.state = .listing
			self.searchMovies = matchingMovies
			self.collectionView?.reloadData()
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.enablesReturnKeyAutomatically = false
	}
}

extension PopularMoviesVCModel {
	enum ApplicationState {
		case initializing
		case loading
		case listing
		case errorSearchNotFound
		case errorFatal
	}
	
	private func changeApplication(state: ApplicationState){
		hideAllViewContainers()
		switch state {
		case .initializing:
			break
		case .loading:
			startsLoading()
		case .listing:
			startsListing()
		case .errorFatal:
			startsFatalError()
		case .errorSearchNotFound:
			startsSearchError()
		}
	}
	
	private func hideAllViewContainers(){
		collectionView?.isHidden = true
		activityIndicator?.isHidden = true
		errorView?.isHidden = true
		errorNoResults?.isHidden = true
	}
	
	private func startsLoading(){
		activityIndicator?.isHidden = false
		activityIndicator?.startAnimating()
		fetchMovies { (success) -> () in
			if success {
				self.state = .listing
			} else {
				self.state = .errorFatal
			}
		}
		activityIndicator?.stopAnimating()
	}
	
	private func startsFatalError(){
		errorView?.isHidden = false
	}
	
	private func startsSearchError(){
		let errorViewModel = PopularMoviesErrorViewModel.standard(searchText: searchBar?.text ?? "")
		errorNoResults?.setup(viewModel: errorViewModel)
		errorNoResults?.isHidden = false
	}
	
	private func startsListing(){
		collectionView?.isHidden = false
	}
}
