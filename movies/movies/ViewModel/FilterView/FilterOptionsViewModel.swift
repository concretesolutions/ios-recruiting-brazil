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
        guard index < self.options.count else { return } // Check if it is an valid index
        
        if isSelected(at: index) { // Check if the given index is on the list of selected options
            let selected = filter.selected.value.filter { $0 != index } // Remove the given index from the list
            
            self.filter.selected.send(selected) // Send new selected value withput the given index
        } else {
            self.filter.selected.send(self.filter.selected.value + [index]) // Send new selected value with new index
        }
    }
    
    public func isSelected(at index: Int) -> Bool {
        guard index < self.options.count else { return false } // Check if it is an valid index
        return self.filter.selected.value.contains(index)
    }
}
