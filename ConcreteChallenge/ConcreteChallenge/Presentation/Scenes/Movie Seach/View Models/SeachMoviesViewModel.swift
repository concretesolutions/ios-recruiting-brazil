//
//  SeachMoviesViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// it is a view model that encapsules a normal moviesViewModel and provides search data to the view.
protocol SeachMoviesViewModel {
    var moviesViewModel: MoviesListViewModel { get }
    var numberOfSuggestions: Int { get }
    var needReloadSuggestions: (() -> Void)? { get set }
    var needChangeSuggestionsVisibility: ((_ visible: Bool) -> Void)? { get set }
    
    func userUpdatedSearchQuery(query: String)
    func userTappedSearchButton()
    func userTappedCancelSearch()
    
    func suggestionAt(position: Int) -> String
}
