//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 14/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var tableView: UITableView!
  
  // MARK: - Private properties
  
  fileprivate var viewModel: MovieDetailViewModel!
  fileprivate var datasource: MovieDetailDatasource!
  
  // MARK: - Initializers
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    viewModel = MovieDetailViewModel(with: MovieDetailDatasource())
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    viewModel = MovieDetailViewModel(with: MovieDetailDatasource())
  }
  
  init(with viewModel: MovieDetailViewModel) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
    self.datasource = viewModel.dataSource
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.customizeNavigationBar()
    self.configureTableView()
  }
  
  // MARK: - Private methods
  
  fileprivate func customizeNavigationBar() {
    self.title = "detail-title".localized()
    
    self.configureTitleNavigationBar(#colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1))
    self.configureNavigationBar(tintColor: #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1), barColor: #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1))
  }
  
  fileprivate func configureTableView() {
    datasource.delegate = self
    
    tableView.dataSource = datasource
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

    tableView.register(UINib(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailCell")
  }
  
}

extension MovieDetailViewController: MoviesActionDelegate {
  
  func handlerFavorite(_ movie: Movies, isFaved: Bool, callback: @escaping ((Bool) -> Void)) {
    viewModel.handlerFavorite(movie, isFaved: isFaved, callback: callback)
  }
  
  func notifyActionError(_ error: String) {
    self.showErrorMessage(error, withTryAgainButton: false)
  }
  
}
