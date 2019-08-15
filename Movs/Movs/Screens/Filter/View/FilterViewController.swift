//
//  FilterViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 12/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {

  // MARK: - Outlets
  
  @IBOutlet weak fileprivate var tableView: UITableView!
  @IBOutlet weak fileprivate var applyButton: UIButton!
  
  // MARK: - Private properties
  
  fileprivate var viewModel: FilterViewModel!
  fileprivate var datasource: FilterDatasource = FilterDatasource()
  
  // MARK: - Initializers
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    viewModel = FilterViewModel(with: self, datasource: datasource)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    viewModel = FilterViewModel(with: self, datasource: datasource)
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.customizeNavigationBar()
    self.configureTableView()
  }
  
  // MARK: - Private methods
  
  fileprivate func customizeNavigationBar() {
    self.title = "filter-title".localized()
    
    self.configureTitleNavigationBar(#colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1))
    self.configureNavigationBar(tintColor: #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1), barColor: #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1))
    
    self.applyButton.setTitle("apply-filter-title".localized(), for: .normal)
    self.applyButton.roundedCorners(10)
  }
  
  fileprivate func configureTableView() {
    tableView.allowsMultipleSelectionDuringEditing = false
    tableView.dataSource = datasource
    tableView.tableFooterView = UIView(frame: .zero)
    
    tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
  }
  
  // MARK: - Actions
  
  @IBAction fileprivate func applyFilterClick() {
    print("apply")
  }
  
}

extension FilterViewController: FilterViewModelDelegate {
  
  func onFilterSelected() {
    self.tableView.reloadData()
    self.applyButton.isEnabled = viewModel.hasFilterSelected()
    self.applyButton.backgroundColor = viewModel.hasFilterSelected() ? #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1) : #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
  }
  
}

extension FilterViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let filter = FilterOptions.allCases[indexPath.row]
    let type: GenericListParamsType = filter == .date ? .dates : .genres
    let genericListViewModel = viewModel.goToGenericList(with: type)

    guard let navigationController = self.navigationController else {
      return
    }

    let genericListController = GenericListViewController(with: genericListViewModel)

    navigationController.pushViewController(genericListController, animated: true)
  }
  
}
