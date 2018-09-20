//
//  ListMoviesPresenter.swift
//  Movs
//
//  Created by Lucas Ferraço on 15/09/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListMoviesPresentationLogic {
	func presentMovies(with response: ListMovies.GetMovies.Response)
    func presentUpdatedMovies(with response: ListMovies.UpdateMovies.Response)
	func mountMovieImage(from data: Data) -> UIImage
    func formatMovieInfo(from movieInfo: ListMovies.MovieInfo) -> ListMovies.FormattedMovieInfo
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
	weak var viewController: ListMoviesDisplayLogic?
	
	// MARK: Present Movies
	
	func presentMovies(with response: ListMovies.GetMovies.Response) {
		let formattedMovies = response.movies?.map(formatMovieInfo)
		
		var message: String? = nil
		if let error = response.error {
			message = getMessage(for: error)
		}
		
		let viewModel = ListMovies.GetMovies.ViewModel(isSuccess: response.isSuccess, moviesInfo: formattedMovies, errorMessage: message)
		DispatchQueue.main.async {
			self.viewController?.displayMovieList(with: viewModel)
		}
	}
    
    // MARK: Present Updated Movies
    
    func presentUpdatedMovies(with response: ListMovies.UpdateMovies.Response) {
        let formattedMovies = response.movies.map(formatMovieInfo)
        let viewModel = ListMovies.UpdateMovies.ViewModel(moviesInfo: formattedMovies)
        DispatchQueue.main.async {
            self.viewController?.displayUpdatedMovies(with: viewModel)
        }
    }
	
	
	func mountMovieImage(from data: Data) -> UIImage {
		var presentedImage = UIImage(named: "defaultPoster")!
		if let image = UIImage(data: data) {
			presentedImage = image
		}
		
		return presentedImage
	}
    
    //MARK: Format Movie Info

    func formatMovieInfo(from movieInfo: ListMovies.MovieInfo) -> ListMovies.FormattedMovieInfo {
        var mainGenre: String? = nil
        if let firstGenre = movieInfo.genres?.first {
            mainGenre = firstGenre
        }
        
        let release = DateFormatter.localizedString(from: movieInfo.releaseDate, dateStyle: .short, timeStyle: .none)
        
        return ListMovies.FormattedMovieInfo(id: movieInfo.id, title: movieInfo.title, mainGenre: mainGenre, release: release, isFavorite: movieInfo.isFavorite)
    }
	
	// MARK: Auxiliary methods
	
	private func getMessage(for error: ListMovies.RequestError) -> String {
		switch error {
		case .NoConnection:
			return "You doesn't seem to have an internet connectio. Connect you device and try again."
		case .Failure:
			return "Sorry, we are having problems to get a movie list for you."
        case .AllMoviesDownloaded:
            return "All movies downloaded. Enjoy! 😄"
        }
	}
}
