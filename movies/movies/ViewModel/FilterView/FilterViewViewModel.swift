//
//  FilterViewViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 10/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

class FilterViewViewModel {
    let filters: [Filter]
    let subject: CurrentValueSubject<[Filter], Never>
    
    // Cancellables
    private var filtersSubscriber: AnyCancellable?
    
    init(filterSubject: CurrentValueSubject<[Filter], Never>) {
        self.filters = filterSubject.value.map { $0.copy() }
        self.subject = filterSubject
    }
    
    public func viewModelForFilter(at index: Int) -> FilterCategoryCellViewModel? {
        guard index < filters.count else { return nil }
        return FilterCategoryCellViewModel(filter: filters[index])
    }
    
    public func applyFilters() {
        self.subject.send(filters.map { $0.copy() })
    }
}
