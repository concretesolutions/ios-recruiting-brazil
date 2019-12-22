//
//  SeachMoviesViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

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

class DefaultSeachMoviesViewModel: SeachMoviesViewModel {
    var needReloadSuggestions: (() -> Void)? {
        didSet {
            self.needReloadSuggestions?()
        }
    }
    
    var numberOfSuggestions: Int {
        return searchSuggestion?.count ?? suggestions?.count ?? 0
    }
    var needChangeSuggestionsVisibility: ((Bool) -> Void)? {
        didSet {
            self.needChangeSuggestionsVisibility?(true)
        }
    }
    
    var moviesViewModel: MoviesListViewModel
    private var moviesSearchRepository: SearchMoviesRepository
    private let suggestionsRepository: SuggestionsRepository
    private var currentQuery: String? {
        didSet {
            if let currentQuery = self.currentQuery {
                self.needChangeSuggestionsVisibility?(true)
                if !currentQuery.isEmpty {
                    searchSuggestion = suggestions?.array.filter({ (suggestion) -> Bool in
                        return suggestion.name.contains(currentQuery)
                    })
                } else {
                    searchSuggestion = nil
                }
            }
        }
    }
    private var searchSuggestion: [Suggestion]? {
        didSet {
            self.needReloadSuggestions?()
        }
    }
    
    private var suggestions: Queue<Suggestion>? {
        didSet {
            self.suggestions?.elementWasRemovedCompletion = { [weak self] removedSuggestion in
                self?.suggestionsRepository.removeSuggestion(suggestion: removedSuggestion) { (result) in
                    switch result {
                    case .failure:
                        fatalError("Suggestions incosistence")
                    default:
                        break
                    }
                }
            }
        }
    }
    
    init(moviesSearchRepository: SearchMoviesRepository,
         suggestionsRepository: SuggestionsRepository,
         movieViewModelInjector: Injector<MoviesListViewModel, (repository: MoviesRepository, emptyState: String)>) {
        
        self.moviesSearchRepository = moviesSearchRepository
        self.suggestionsRepository = suggestionsRepository
        self.moviesViewModel = movieViewModelInjector((moviesSearchRepository, "No search results."))
        
        self.moviesSearchRepository.searchQueryProvider = { [weak self] in
            return self?.currentQuery ?? nil
        }
        
        getSuggestions()
    }

    func userUpdatedSearchQuery(query: String) {
        self.currentQuery = query
    }
    
    func userTappedSearchButton() {
        self.moviesViewModel.deleteAllMovies()
        self.moviesViewModel.thePageReachedTheEnd()
        self.needChangeSuggestionsVisibility?(false)
        
        guard let currentQuery = self.currentQuery else {
            return
        }
        
        let newSuggestion = Suggestion(name: currentQuery, creationDate: Date())
        suggestionsRepository.saveSuggestion(suggestion: newSuggestion){ (result) in
            switch result {
            case .success:
                self.suggestions?.add(newSuggestion)
            default:
                break
            }
        }
    }
    
    func userTappedCancelSearch() {
        self.moviesViewModel.deleteAllMovies()
    }
    
    private func getSuggestions() {
        suggestionsRepository.getSuggestions { (result) in
            switch result {
                
            case .success(let suggestions):
                self.suggestions = .init(elements: suggestions, andLimit: 20)
            case .failure:
                self.suggestions = .init(withLimit: 0)
            }
        }
    }
    
    func suggestionAt(position: Int) -> String {
        guard position >= 0 && position < numberOfSuggestions else {
            fatalError()
        }
        
        if let searchSuggestion = self.searchSuggestion {
            return searchSuggestion[position].name
        }
                
        return self.suggestions?.array[position].name ?? ""
    }
}
