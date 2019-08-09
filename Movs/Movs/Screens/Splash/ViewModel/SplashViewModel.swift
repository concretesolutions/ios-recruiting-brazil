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
  func loadingSettingsError(_ error: String)
}

struct SplashViewModel {
  
  fileprivate var delegate: SplashViewModelDelegate!
  
  init(with delegate: SplashViewModelDelegate) {
    self.delegate = delegate
  }
  
  func fetchSettings() {
    SettingServices.shared.fetchSettings { result in
      switch result {
      case .success(let settings): self.success(settings)
      case .error(let error): self.error(error)
      }
    }
  }
  
  fileprivate func success(_ settings: Settings) {
    // Store loaded settings in application Singleton
    MovsSingleton.shared.globalSettings = settings
    
    guard let delegate = self.delegate else { return }
    delegate.loadSettingsSuccess()
  }
  
  fileprivate func error(_ error: String) {
    guard let delegate = self.delegate else { return }
    delegate.loadingSettingsError(error)
  }
  
}
