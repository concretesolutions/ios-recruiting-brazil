//
//  AddMoviesPresenter.swift
//  DataMovie
//
//  Created by Andre Souza on 14/08/2018.
//  Copyright (c) 2018 Andre. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class AddMoviesPresenter {

    // MARK: - Private properties -

    private unowned var _view: AddMoviesViewInterface
    private var _interactor: AddMoviesInteractorInterface
    private var _wireframe: AddMoviesWireframeInterface
    private var _movieListUpdateProtocol: MovieListUpdateProtocol
    
    private var _segmentDiscoverControllers: [AddListsProtocol] = []
    private lazy var _searchViewController: SearchProtocol? = {
        let searchWF = SearchMoviesWireframe(addMoviesProtocol: self)
        if let searchProtocol = searchWF.viewController as? SearchProtocol {
            return searchProtocol
        }
        return nil
    }()

    // MARK: - Lifecycle -

    init(wireframe: AddMoviesWireframeInterface, view: AddMoviesViewInterface, interactor: AddMoviesInteractorInterface, movieListUpdateProtocol: MovieListUpdateProtocol) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        _movieListUpdateProtocol = movieListUpdateProtocol
    }
}

// MARK: - Extensions -

extension AddMoviesPresenter: AddMoviesPresenterInterface {
    
    func initSegmentedViewControllers() {
        DiscoverContent.allCases.forEach() { discoverContent in
            let discoverWF = DiscoverMoviesWireframe(discoverContent: discoverContent, addMoviesViewProtocol: self)
            if let discoverProtocol = discoverWF.viewController as? AddListsProtocol {
                _segmentDiscoverControllers.append(discoverProtocol)
                _view.insertSegment(title: discoverContent.title, at: discoverContent.index)
            }
        }
        _view.selectedSegmentIndex = DiscoverContent.nowPlaying.index
    }
    
    func showSearchController() {
        _view.activeViewController = _searchViewController?.viewController
        _searchViewController?.clearResults()
        _searchViewController?.showFooterLoading(false)
    }
    
    func findMovie(with title: String) {
        _searchViewController?.findMovie(title)
    }
    
    func activeViewController(at index: Int) -> UIViewController {
        return _segmentDiscoverControllers[index].viewController
    }
    
}

// MARK: - Functions -

extension AddMoviesPresenter {
    
    private func updateItemStatus(with tmdbID: Int, isComplete: Bool) {
        if _view.activeViewController == _searchViewController?.viewController {
            _searchViewController?.updateItemStatus(with: tmdbID, isComplete: isComplete)
        } else {
            _segmentDiscoverControllers[_view.selectedSegmentIndex].updateItemStatus(with: tmdbID, isComplete: isComplete)
        }
    }
    
    private func saveMovie(_ movieModel: MovieModel) {
        guard let tmdbID = movieModel.tmdbID else { return }
        updateItemStatus(with: tmdbID, isComplete: true)
        let movieEntity = MovieEntity(with: movieModel)
        movieEntity.save()
        _movieListUpdateProtocol.setNeedUpdateList()
    }
    
}

// MARK: - AddMoviesProtocol -

extension AddMoviesPresenter: AddMoviesProtocol {
    
    func addMovie(with tmdbID: Int) {
        requestQueue(with: tmdbID)
    }
    
}

// MARK: - Rquests -

extension AddMoviesPresenter {
    
    private func requestQueue(with tmdbID: Int) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let Sself = self else {
                return
            }
            
            // MARK: - Initial variables
            
            var hasError: Bool = false
            var newMovie: MovieModel?
            let errorResponse: ErrorResponse = ErrorResponse("An error has occurred during download.\nPlease try again.")
            
            let dispatchGroup = DispatchGroup()
            //let queueImage = DispatchQueue(label: "com.image")
            //let queueVideo = DispatchQueue(label: "com.video")
            
            // MARK: - REQUEST movie detail
            
            dispatchGroup.enter()
            Sself._interactor.getMovieDetail(tmdbID: tmdbID, { result in
                switch result {
                case .success(let detail):
                    newMovie = detail
                    break
                case .failure(_):
                    hasError = true
                    break
                }
                dispatchGroup.leave()
            })
            dispatchGroup.wait()
            
            // MARK: - REQUEST movie poster
            
            if !hasError, let posterPath = newMovie?.posterPath {
                dispatchGroup.enter()
                Sself._interactor.downloadPoster(posterPath: posterPath, { response in
                    switch(response.result) {
                    case .success(let imageData):
                        
                        guard
                            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                            else { fallthrough }
                        
                        let imageFileName = posterPath.replacingOccurrences(of: "/", with: "")
                        let imageFileURL = fileURL.appendingPathComponent(imageFileName)
                        
                        do {
                            try imageData.write(to: imageFileURL, options: [.atomic])
                            newMovie?.posterPath = imageFileName
                        } catch {
                            hasError = true
                        }
                        
                        break
                    case .failure(_):
                        hasError = true
                        break
                    }
                    dispatchGroup.leave()
                })
                dispatchGroup.wait()
            }
            
            // MARK: - End of the block
            
            DispatchQueue.main.async {
                Sself.updateItemStatus(with: tmdbID, isComplete: !hasError)
                if hasError {
                    Sself._wireframe.showAlert(with: errorResponse.title, message: errorResponse.message)
                } else if let movie = newMovie {
                    Sself.saveMovie(movie)
                }
            }
        }
    }
}
