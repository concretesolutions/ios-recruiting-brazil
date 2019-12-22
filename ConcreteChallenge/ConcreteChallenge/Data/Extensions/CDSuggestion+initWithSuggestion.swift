//
//  CDSuggestion+initWithSuggestion.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import CoreData

extension CDSuggestion {
    @discardableResult
    convenience init(movie: Suggestion, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = movie.name
        self.creationDate = movie.creationDate
    }
}
