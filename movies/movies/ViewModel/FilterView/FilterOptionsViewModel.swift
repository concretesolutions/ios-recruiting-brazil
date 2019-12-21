//
//  FilterOptionsViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 18/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class FilterOptionsViewModel {
    private let filter: Filter
    
    var name: String {
        return filter.name
    }
    
    var options: [String] {
        return filter.options
    }
    
    init(filter: Filter) {
        self.filter = filter
    }
    
    public func toggleSelection(at index: Int) {
        guard index < self.options.count else { return }
        
        if isSelected(at: index) {
            let selected = filter.selected.value.filter { $0 != index }
            
            self.filter.selected.send(selected)
        } else {
            self.filter.selected.send(self.filter.selected.value + [index])
        }
    }
    
    public func isSelected(at index: Int) -> Bool {
        guard index < self.options.count else { return false }
        return self.filter.selected.value.contains(index)
    }
}
