//
//  GenericListViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 12/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

protocol GenericListDelegate {
  func onSelectDate(with date: String)
  func onSelectGenres(with genres: [Int])
}

struct GenericListViewModel {
  
  fileprivate let params: GenericListParams
  fileprivate let delegate: GenericListDelegate
  let datasource: GenericListDatasource
  
  // MARK: - Public properties
  
  var screenTitle: String {
    return params.title
  }
  
  var listType: GenericListParamsType {
    return params.type
  }
  
  // MARK: - Life cycle
  
  init(with params: GenericListParams, datasource: GenericListDatasource, delegate: GenericListDelegate) {
    self.params = params
    self.datasource = datasource
    self.delegate = delegate
    
    self.populateDatasourceInfos()
  }
  
  // MARK: - Private methods
  
  fileprivate func populateDatasourceInfos() {
    datasource.items = params.items
    
    // Convert selected value(s) in 'indexPath' array
    switch listType {
    case .dates: self.makeDateIndex()
    case .genres: self.makeGenresIndex()
    }
  }
  
  fileprivate func makeDateIndex() {
    guard let selectedYear = params.selectedYear, let row = MovsSingleton.shared.avaliableDates.firstIndex(of: selectedYear) else {
      return
    }

    let index = IndexPath(row: row, section: 0)
    datasource.selectedIndexes = [index]
  }
  
  fileprivate func makeGenresIndex() {
    guard let genres = params.selectedGenres else { return }
    let genresList = MovsSingleton.shared.genres
    var selectedIndexes = [IndexPath]()

    for genre in genres {
      if let index = genresList.firstIndex(where: { $0.id == genre } ) {
        selectedIndexes.append(IndexPath(row: index, section: 0))
      }
    }
    
    datasource.selectedIndexes = selectedIndexes
  }
  
  fileprivate func clearSelectionIfNeeded() {
    if listType == .dates && datasource.selectedIndexes.count > 0 {
      datasource.selectedIndexes.removeAll()
    }
  }
  
  fileprivate func makeSelectedDate() -> String {
    guard let selectedIndex = datasource.selectedIndexes.first else {
      return ""
    }
    
    let dateSelected = MovsSingleton.shared.avaliableDates[selectedIndex.row]
    return dateSelected
  }
  
  fileprivate func makeSelectedGenres() -> [Int] {
    var genres = [Int]()
    let genresList = MovsSingleton.shared.genres
    
    for selectedItem in datasource.selectedIndexes {
      let genre = genresList[selectedItem.row].id
      genres.append(genre)
    }
    
    return genres
  }
  
  // MARK: - Public methods
  
  func selectItem(with index: IndexPath) {
    //. Clear previous selected item if needed
    self.clearSelectionIfNeeded()

    datasource.selectedIndexes.append(index)
  }
  
  func unselectItem(with index: IndexPath) -> Bool {
    guard let indexOf = datasource.selectedIndexes.firstIndex(of: index) else {
      return false
    }
    
    datasource.selectedIndexes.remove(at: indexOf)
    
    return true
  }
  
  func confirmSelectedDate() {
    let dateSelected = self.makeSelectedDate()
    delegate.onSelectDate(with: dateSelected)
  }
  
  func confirmSelectedGenres() {
    let genres = self.makeSelectedGenres()
    delegate.onSelectGenres(with: genres)
  }
  
  func hasSelection() -> Bool {
    return datasource.selectedIndexes.count > 0
  }
  
}
