//
//  MoviesListClient.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

typealias MoviesPages = [[MovieModel]]

class MoviesListClient {
    
    var moviesList: MoviesPages = []
    
    private lazy var service = Service()
    private var totalPages: Int = 1
    private var configurationModel: TMDBConfigurationModel? {
        didSet {
            saveConfigs()
        }
    }
    
    private var actualPage: Int {
        return moviesList.count
    }
    
    private var moviePage: Int {
        if moviesList.isEmpty {
            return 1
        } else {
            return actualPage + 1
        }
    }
    
    init() {
        getConfigurationModel()
    }
    
    public func cancelTask() {
        service.cancelActiveTasks()
    }
}

//MARK: - GetMovies methods -
extension MoviesListClient {
    func getMoviesList(completion: @escaping (ResponseResultType<Int>) -> Void) {
        let url = TMDBUrl().getUrl(to: .moviesList, and: moviePage)
        if actualPage > totalPages { return }
        service.get(in: url) { [weak self] (result: ResponseResultType<MoviesListModel>) in
            switch result {
            case let .success(moviesListResult):
                self?.doSuccessTreat(with: moviesListResult, completion: completion)
            case let .fail(error):
                self?.doErrorTreat(with: error, completion: completion)
            }
        }
    }
    
    private func doSuccessTreat(with moviesListResult: MoviesListModel, completion: @escaping (ResponseResultType<Int>) -> Void) {
        totalPages = moviesListResult.totalPages
        moviesList.append(moviesListResult.moviesList)
        completion(.success(moviesListResult.page))
    }
    
    private func doErrorTreat(with error: Error, completion: @escaping (ResponseResultType<Int>) -> Void) {
        completion(.fail(error))
    }
}

//MARK: - GetMoviePoster methods -
extension MoviesListClient {
    func getMoviePoster(posterPath: String, completion: @escaping (ResponseResultType<Data>, String) -> Void) {
        
        if let _ = configurationModel {
            downloadMoviePoster(posterPath: posterPath, completion: completion)
        } else {
            getConfigurationModel { [weak self] hasConfigModel in
                if hasConfigModel {
                    self?.downloadMoviePoster(posterPath: posterPath, completion: completion)
                } else {
                    let urlError = NSError(domain: NSURLErrorDomain, code: 1002, userInfo: nil)
                    completion(.fail(urlError), posterPath)
                }
            }
        }
        
    }
    
    private func downloadMoviePoster(posterPath: String, completion: @escaping (ResponseResultType<Data>, String) -> Void) {
        let defaultPosterSize = "w500"
        guard
            let configModel = configurationModel,
            let baseURL = configModel.images?.safeBaseURL,
            let posterUrl = URL(string: baseURL + defaultPosterSize + posterPath)
            else {
                let urlError = NSError(domain: NSURLErrorDomain, code: 1002, userInfo: nil)
                return completion(.fail(urlError), posterPath)
        }
        
        service.getImage(in: posterUrl) { result, url in
            switch result {
            case let .success(data):
                completion(.success(data), self.getPosterPath(from: url))
            case let .fail(error):
                completion(.fail(error), self.getPosterPath(from: url))
            }
        }
    }
    
    private func getPosterPath(from url: URL?) -> String {
        guard let posterURL = url else { return "" }
        return "/\(posterURL.absoluteURL.lastPathComponent)"
    }
}

//MARK: - GetConfiguration methods -
extension MoviesListClient {
    func getConfigurationModel(completion: ((Bool) -> Void)? = nil) {
        let url = TMDBUrl().getUrl(to: .configuration)
        service.get(in: url) { [weak self] (result: ResponseResultType<TMDBConfigurationModel>) in
            switch result {
            case let .success(configModel):
                self?.configurationModel = configModel
                completion?(true)
            case .fail(_):
                completion?(false)
            }
        }
    }
    
    private func saveConfigs() {
        guard
            let configs = configurationModel,
            let data = try? JSONEncoder().encode(configs)
        else { return }
        
        let userDefaults = UserDefaultWrapper()
        userDefaults.save(object: data, with: userDefaults.configModelKey)
    }
}
