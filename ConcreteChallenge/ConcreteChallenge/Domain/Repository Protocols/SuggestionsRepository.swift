//
//  SuggestionsRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol SuggestionsRepository {
    func getSuggestions(completion: @escaping (Result<[Suggestion],Error>) -> Void)
    func saveSuggestion(suggestion: Suggestion, completion: @escaping (ActionResult<Error>) -> Void)
    func removeSuggestion(suggestion: Suggestion, completion: @escaping (ActionResult<Error>) -> Void)
}
