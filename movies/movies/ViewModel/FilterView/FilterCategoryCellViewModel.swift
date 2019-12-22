//
//  FilterCategoryCellViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 18/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

class FilterCategoryCellViewModel {
    private let filter: Filter
    
    var name: String {
        return filter.name
    }
    
    // Publishers
    @Published var options: String = ""
    
    // Cancellables
    var selectedSubscriber: AnyCancellable?
    
    init(filter: Filter) {
        self.filter = filter
        
        // Observe changes in selected state of filter
        self.selectedSubscriber = self.filter.selected
            .receive(on: DispatchQueue.main)
            .map({ [weak self] indexes -> [String] in
                // Convert the list of option indexes into their string value
                indexes.compactMap { self?.filter.options[$0] }
            })
            .sink(receiveValue: { [weak self] optionsList in
                // Set options string to the values of the selected options
                let options = optionsList.reduce("") { (options, option) -> String in
                    "\(options), \(option)"
                }
                
                self?.options = String(options.dropFirst(2))
            })
    }
}
