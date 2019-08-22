//
//  SplashViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

protocol SplashViewModelDelegate {
  func loadSettingsSuccess()
  func loadSettingsError(_ error: String)
  func loadGenresSuccess()
  func loadGenresError(_ error: String)
  func favoritesLoaded()
}

struct SplashViewModel {
  
  fileprivate var delegate: SplashViewModelDelegate!
  
  // MARK: - Life cycle
  
  init(with delegate: SplashViewModelDelegate) {
    self.delegate = delegate
  }
  
  // MARK: - Public methods
  
  func fetchSettings() {
    SettingServices.shared.fetchSettings { result in
      switch result {
      case .success(let settings): self.success(settings)
      case .error(let error): self.error(error)
      }
    }
  }
  
  func fetchGenres() {
    GenreServices.shared.fetchGenres { result in
      switch result {
      case .success(let genres): self.genresSuccess(genres)
      case .error(let error): self.genreError(error)
      }
    }
  }
  
  func fectchFavorites() {
    DataManager.shared.loadFavedMovies {
      self.delegate.favoritesLoaded()
    }
  }
  
  // MARK: - Private methods
  
  fileprivate func success(_ settings: Settings) {
    // Store loaded settings in application Singleton
    MovsSingleton.shared.globalSettings = settings
    
    guard let delegate = self.delegate else { return }
    delegate.loadSettingsSuccess()
  }
  
  fileprivate func error(_ error: String) {
    guard let delegate = self.delegate else { return }
    delegate.loadSettingsError(error)
  }
  
  fileprivate func genresSuccess(_ genres: [Genres]) {
    // Store loaded genres list in application Singleton
    MovsSingleton.shared.genres.removeAll()
    MovsSingleton.shared.genres.append(contentsOf: genres)

    guard let delegate = self.delegate else { return }
    delegate.loadGenresSuccess()
  }
  
  fileprivate func genreError(_ error: String) {
    guard let delegate = self.delegate else { return }
    delegate.loadSettingsError(error)
  }
  
}
