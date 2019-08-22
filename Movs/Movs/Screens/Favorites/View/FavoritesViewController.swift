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
  @IBOutlet weak fileprivate var searchEmptyView: UIView!
  @IBOutlet weak fileprivate var searchEmptyLabel: UILabel!
  @IBOutlet weak fileprivate var filterEmptyView: UIView!
  @IBOutlet weak fileprivate var filterEmptyLabel: UILabel!
  @IBOutlet weak fileprivate var favoritesEmptyView: UIView!
  @IBOutlet weak fileprivate var favoritesEmptyLabel: UILabel!
  @IBOutlet weak var filterContainerHeightConstraint: NSLayoutConstraint! // 52
  
  // MARK: - Private properties
  
  fileprivate var state: ViewState = .normal {
    didSet {
      self.setupView()
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
    self.configureEmptyView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let elegibleToLoad = !self.datasource.inSearch && !self.datasource.filterEnable
    
    DispatchQueue.main.async { [weak self] in
      if elegibleToLoad {
        self?.loadFavoriteMovies()
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.searchBar.endEditing(true)
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
  
  fileprivate func configureEmptyView() {
    favoritesEmptyLabel.text = "empty-favorites-label".localized()
    searchEmptyLabel.text = "empty-search-label".localized()
    filterEmptyLabel.text = "empty-filter-label".localized()
  }
  
  fileprivate func loadFavoriteMovies() {
    self.state = .loading
    viewModel.fetchFavorites()
  }
  
  fileprivate func setupView() {
    switch state {
    case .loading:
      self.searchEmptyView.isHidden = true
      self.favoritesEmptyView.isHidden = true
      self.tableView.isHidden = true
      self.activityIndicator.startAnimating()
      
    case .normal:
      self.activityIndicator.stopAnimating()
      self.searchEmptyView.isHidden = true
      self.handlerEmptyView()
      self.tableView.isHidden = false
      
    case .searching(let hasResult): self.endSearch(hasResult: hasResult)
    case .filter(let hasResult): self.handlerFilter(hasResult: hasResult)
      
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

    let filterController = FilterViewController(with: self)
    filterController.hidesBottomBarWhenPushed = true
    
    navigationController.pushViewController(filterController, animated: true)
  }
  
  fileprivate func handlerEmptyView() {
    favoritesEmptyView.isHidden = viewModel.hasFavorites
  }
  
  fileprivate func endSearch(hasResult: Bool) {
    searchEmptyView.isHidden = hasResult
  }
  
  fileprivate func handlerFilter(hasResult: Bool) {
    filterEmptyView.isHidden = hasResult
  }
  
  fileprivate func performSearch(_ term: String) {
    viewModel.search(with: term)
  }
  
  @IBAction fileprivate func removeFiltersClick() {
    self.filterContainerHeightConstraint.constant = 0
    
    UIView.animate(withDuration: 0.5, animations: {}) { [weak self] finished in
      if finished {
        self?.removeFilterButton.isHidden = true
      }
    }
    
    viewModel.clearFilter()
  }
  
}

extension FavoritesViewController: FavoritesViewModelDelegate {
  
  func loadFavoritesSuccess() {
    self.state = .normal
    tableView.reloadData()
  }
  
  func loadFavoritesError(_ error: String) {
    self.state = .error
    
    self.showErrorMessage(error, tryAgainCallback: { [weak self] in
      self?.loadFavoriteMovies()
    })
  }
  
  func searchWithResult() {
    self.state = .searching(hasResult: true)
    self.tableView.reloadData()
  }
  
  func searchEmpty() {
    self.state = .searching(hasResult: false)
  }
  
  func filterWithResult() {
    self.state = .filter(hasResult: true)
    self.tableView.reloadData()
  }
  
  func filterEmpty() {
    self.state = .filter(hasResult: false)
  }
  
  func clearSearch() {
    self.state = .searching(hasResult: true)
    self.tableView.reloadData()
  }
  
  func clearFilter() {
    self.state = .filter(hasResult: true)
    self.tableView.reloadData()
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
      
      if datasource.inSearch {
        viewModel.clearSearch()
      }
    }
    
    return true
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text, !searchText.trim().isEmpty else {
      self.showErrorMessage("empty-search-error".localized(), withTryAgainButton: false)
      return
    }
    
    searchBar.endEditing(true)
    
    self.performSearch(searchText)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if datasource.inSearch && searchText.isEmpty {
      viewModel.clearSearch()
    }
  }
  
}

extension FavoritesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteButton = UITableViewRowAction(style: .destructive, title: "unfaved-action-title".localized()) { [weak self] (action, indexPath) in
      
      self?.viewModel.removeFavorite(at: indexPath)

      tableView.beginUpdates()
      tableView.deleteRows(at: [indexPath], with: .automatic)
      tableView.reloadData()
      tableView.endUpdates()
      
      self?.handlerEmptyView()

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
    let movieDetailViewModel = viewModel.makeMovieDetail(at: indexPath)
    let movieDetailController = MovieDetailViewController(with: movieDetailViewModel)
    
    self.navigationController?.pushViewController(movieDetailController, animated: true)
  }

}

extension FavoritesViewController: FilterDelegate {
  
  func onApplyFilter(with filters: Filters) {
    self.removeFilterButton.isHidden = false

    UIView.animate(withDuration: 0.5) {
      self.filterContainerHeightConstraint.constant = 52
    }
    
    // Applying selected filters
    viewModel.applyFilter(filters)
  }
  
}
