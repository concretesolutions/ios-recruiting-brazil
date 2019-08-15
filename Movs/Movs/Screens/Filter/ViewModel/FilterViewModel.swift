//
//  FilterViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 11/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

enum FilterOptions {
  case date
  case genres
  
  var title: String {
    switch self {
    case .date: return "filter-by-date-title".localized()
    case .genres: return "filter-by-genre-title".localized()
    }
  }
  
  static let allCases: [FilterOptions] = [.date, .genres]
}

protocol FilterViewModelDelegate {
  func onFilterSelected()
}

struct FilterViewModel {
  
  fileprivate let delegate: FilterViewModelDelegate!
  fileprivate let dataSource: FilterDatasource!
  
  // MARK: - Life cycle
  
  init(with delegate: FilterViewModelDelegate, datasource: FilterDatasource) {
    self.delegate = delegate
    self.dataSource = datasource
  }
  
  // MARK: - Private methods
  
  fileprivate func makeDatesList() -> GenericListViewModel {
    let items = MovsSingleton.shared.avaliableDates
    let params = GenericListParams(type: .dates, title: "filter-by-date-title".localized(), items: items, selectedYear: dataSource.filtersApplyed.year)
    
    let datasource = GenericListDatasource()
    let viewModel = GenericListViewModel(with: params, datasource: datasource, delegate: self)
    
    return viewModel
  }
  
  fileprivate func makeGenresList() -> GenericListViewModel {
    let items = MovsSingleton.shared.genres.map { $0.name }
    let params = GenericListParams(type: .genres, title: "filter-by-genre-title".localized(), items: items, selectedGenres: dataSource.filtersApplyed.genres)

    let datasource = GenericListDatasource()
    let viewModel = GenericListViewModel(with: params, datasource: datasource, delegate: self)

    return viewModel
  }
  
  fileprivate func notifyFilterSelected() {
    delegate.onFilterSelected()
  }
  
  // MARK: - Public methods
  
  func goToGenericList(with type: GenericListParamsType) -> GenericListViewModel {
    switch type {
    case .dates: return self.makeDatesList()
    case .genres: return self.makeGenresList()
    }
  }
  
  func hasFilterSelected() -> Bool {
    return !dataSource.filtersApplyed.year.isEmpty || dataSource.filtersApplyed.genres.count > 0
  }
  
}

extension FilterViewModel: GenericListDelegate {
  
  func onSelectDate(with date: String) {
    dataSource.filtersApplyed.year = date
    notifyFilterSelected()
  }
  
  func onSelectGenres(with genres: [Int]) {
    dataSource.filtersApplyed.genres = genres
    notifyFilterSelected()
  }
  
}
