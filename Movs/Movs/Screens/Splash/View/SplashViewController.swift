//
//  SplashViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Private properties
  
  fileprivate var state: ViewState = .normal {
    didSet {
      self.setupView()
    }
  }
  
  fileprivate var viewModel: SplashViewModel!
  
  // MARK: - Initializers
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    viewModel = SplashViewModel(with: self)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    viewModel = SplashViewModel(with: self)
  }
  
  // MARK: - Life cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    DispatchQueue.main.async { [weak self] in
      self?.loadSettings()
    }
  }
  
  // MARK: - Private methods
  
  fileprivate func loadSettings() {
    self.state = .loading
    viewModel.fetchSettings()
  }
  
  fileprivate func loadGenres() {
    self.state = .loading
    viewModel.fetchGenres()
  }
  
  fileprivate func setupView() {
    switch state {
    case .loading: self.activityIndicator.startAnimating()
    default: self.activityIndicator.stopAnimating()
    }
  }
  
  fileprivate func goToHome() {
    print("Show movies list")
  }

}

extension SplashViewController: SplashViewModelDelegate {
  
  func loadSettingsSuccess() {
    // Start load of genres list
    self.loadGenres()
  }
  
  func loadingSettingsError(_ error: String) {
    self.state = .error
    
    self.showErrorMessage(error, tryAgainCallback: { [weak self] in
      self?.loadSettings()
    })
  }
  
  func loadGenresSuccess() {
    self.state = .normal
    self.goToHome()
  }
  
  func loadGenresError(_ error: String) {
    self.state = .error
    
    self.showErrorMessage(error, tryAgainCallback: { [weak self] in
      self?.loadGenres()
    })
  }
  
}
