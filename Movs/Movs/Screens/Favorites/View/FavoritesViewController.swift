//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 11/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak fileprivate var searchBar: UISearchBar!
  @IBOutlet weak fileprivate var tableView: UITableView!
  @IBOutlet weak fileprivate var removeFilterButton: UIButton!
  @IBOutlet weak var filterContainerHeightConstraint: NSLayoutConstraint! // 52
  
  // MARK: - Private properties
  
  fileprivate var state: ViewState = .normal {
    didSet {
      //      self.setupView()
    }
  }
  
  fileprivate var viewModel: FavoritesViewModel!
  fileprivate var datasource: FavoritesDatasource = FavoritesDatasource()
  
  // MARK: - Initializers
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    viewModel = FavoritesViewModel(with: self, datasource: datasource)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    viewModel = FavoritesViewModel(with: self, datasource: datasource)
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.customizeNavigationBar()
    self.configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    DispatchQueue.main.async { [weak self] in
      self?.loadFavoriteMovies()
    }
  }
  
  // MARK: - Private methods
  
  fileprivate func customizeNavigationBar() {
    self.title = "faved-title".localized()
    
    self.configureTitleNavigationBar(#colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1))
    self.configureNavigationBar(tintColor: #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1), barColor: #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1))
    self.configureSearchField(in: searchBar, with: #colorLiteral(red: 0.8509803922, green: 0.5921568627, blue: 0.1176470588, alpha: 1), and: #colorLiteral(red: 0.4862745098, green: 0.4745098039, blue: 0.4745098039, alpha: 1))
    
    // Add filter button
    self.addRightBarButtonItem(with: #imageLiteral(resourceName: "filter-icon"), target: self, action: #selector(filterAction))
    self.removeFilterButton.setTitle("clear-filter".localized(), for: .normal)
  }
  
  fileprivate func loadFavoriteMovies() {
    self.state = .loading
    viewModel.fetchFavorites()
  }
  
  fileprivate func setupView() {
    switch state {
    case .loading: self.activityIndicator.startAnimating()
    default: self.activityIndicator.stopAnimating()
    }
  }
  
  fileprivate func configureTableView() {
    tableView.allowsMultipleSelectionDuringEditing = false
    tableView.dataSource = datasource
    tableView.tableFooterView = UIView(frame: .zero)

    tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesCell")
  }
  
  // MARK: - Interactions
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // MARK: - Actions
  
  @objc fileprivate func filterAction() {
    self.goToFilters()
  }
  
  fileprivate func goToFilters() {
    guard let navigationController = self.navigationController else { return }

    let filterController = FilterViewController()
    filterController.hidesBottomBarWhenPushed = true
    
    navigationController.pushViewController(filterController, animated: true)
  }
  
}

extension FavoritesViewController: FavoritesViewModelDelegate {
  
  func loadFavoritesSuccess() {
    tableView.reloadData()
  }
  
  func loadFavoritesError(_ error: String) {
    self.state = .error
    
    self.showErrorMessage(error, tryAgainCallback: { [weak self] in
      self?.loadFavoriteMovies()
    })
  }
  
}

extension FavoritesViewController: UISearchBarDelegate {
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.clearOffset()
    return true
  }
  
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    if searchBar.text!.isEmpty {
      searchBar.centeredPlaceHolder()
    }
    
    return true
  }
  
}

extension FavoritesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteButton = UITableViewRowAction(style: .destructive, title: "unfaved-action-title".localized()) { (action, indexPath) in

      return
    }

    deleteButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
    return [deleteButton]
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 116
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }

}
