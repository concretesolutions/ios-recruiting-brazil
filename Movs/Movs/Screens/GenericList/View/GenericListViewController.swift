//
//  GenericListViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 12/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class GenericListViewController: BaseViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var tableView: UITableView!
  
  // MARK: - Private properties
  
  fileprivate var viewModel: GenericListViewModel!

  // MARK: - Initializers
  
  init(with viewModel: GenericListViewModel) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.customizeNavigationBar()
    self.configureTableView()
  }
  
  // MARK: - Private methods
  
  fileprivate func customizeNavigationBar() {
    self.title = viewModel.screenTitle
    
    self.configureTitleNavigationBar(#colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1))
    self.configureNavigationBar(tintColor: #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1), barColor: #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1))
    
    // Add the apply button
    let icon = #imageLiteral(resourceName: "check-icon").withRenderingMode(.alwaysTemplate)

    self.addRightBarButtonItem(with: icon, iconTintColor: #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1), target: self, action: #selector(applySelectionClick))
  }
  
  fileprivate func configureTableView() {
    tableView.allowsMultipleSelection = viewModel.listType == .genres
    tableView.dataSource = viewModel.datasource
    tableView.tableFooterView = UIView(frame: .zero)
    
    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableView.automaticDimension
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GenericListItemCell")
  }
  
  // MARK: - Actions
  
  @objc fileprivate func applySelectionClick() {
    switch viewModel.listType {
    case .dates:
      if !self.validateDateSelection() { return }

      self.viewModel.confirmSelectedDate()

    case .genres:
      if !self.validateGenresSelections() { return }

      self.viewModel.confirmSelectedGenres()
    }
    
    self.closeScreen()
  }
  
  fileprivate func validateDateSelection() -> Bool {
    if !viewModel.hasSelection() {
      self.showErrorMessage("date-filter-empty-selection".localized(), withTryAgainButton: false)

      return false
    }

    return true
  }

  fileprivate func validateGenresSelections() -> Bool {
    if !viewModel.hasSelection() {
      self.showErrorMessage("genre-filter-empty-selection".localized(), withTryAgainButton: false)

      return false
    }
    
    return true
  }
  
  fileprivate func closeScreen() {
    self.navigationController?.popViewController(animated: true)
  }
  
}

extension GenericListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if !viewModel.unselectItem(with: indexPath) {
      viewModel.selectItem(with: indexPath)
    }

    tableView.reloadData()
  }

}
