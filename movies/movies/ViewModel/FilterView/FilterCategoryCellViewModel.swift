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
    
    @Published var options: String = ""
    
    // Cancellables
    var selectedSubscriber: AnyCancellable?
    
    init(filter: Filter) {
        self.filter = filter
        
        selectedSubscriber = self.filter.selected
            .receive(on: DispatchQueue.main)
            .map({ [weak self] indexes -> [String] in
                indexes.compactMap { self?.filter.options[$0] }
            })
            .sink(receiveValue: { [weak self] optionsList in
                let options = optionsList.reduce("") { (options, option) -> String in
                    "\(options), \(option)"
                }
                
                self?.options = String(options.dropFirst(2))
            })
    }
}
