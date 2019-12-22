//
//  Suggestion+initWithCDSuggestion.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

extension Suggestion {
    init?(cdSuggestion: CDSuggestion) {
        guard let name = cdSuggestion.name, let date = cdSuggestion.creationDate else {
            return nil
        }
        
        self.init(name: name, creationDate: date)
    }
}
