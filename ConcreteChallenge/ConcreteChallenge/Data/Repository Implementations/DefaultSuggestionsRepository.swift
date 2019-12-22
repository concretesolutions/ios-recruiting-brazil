//
//  DefaultSuggestionsRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import CoreData

class DefaultSuggestionsRepository: SuggestionsRepository {
    func getSuggestions(completion: @escaping (Result<[Suggestion], Error>) -> Void) {
        let movieRequest: NSFetchRequest<CDSuggestion> = CDSuggestion.fetchRequest()
        movieRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]

        do {
            let cdSuggestions = try CoreDataStack.persistentContainer.viewContext.fetch(movieRequest)

            if cdSuggestions.count == 0 {
                let initialSuggestions = defaultSuggestions()
                initialSuggestions.forEach { (suggestion) in
                    self.saveSuggestion(suggestion: suggestion) { (_) in }
                }
                completion(.success(initialSuggestions))
                return
            }
            
            completion(.success(cdSuggestions.compactMap({ (cdSuggestion) -> Suggestion? in
                guard let name = cdSuggestion.name, let date = cdSuggestion.creationDate else {
                    return nil
                }
                return Suggestion(name: name, creationDate: date)
            })))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveSuggestion(suggestion: Suggestion, completion: @escaping (ActionResult<Error>) -> Void) {
        guard getSuggestion(withName: suggestion.name) == nil else {
            completion(.failure(CoreDataErrors.suggestionIsAlreadySaved))
            return
        }
        
        do {
            CDSuggestion(movie: suggestion, context: CoreDataStack.persistentContainer.viewContext)
            try CoreDataStack.persistentContainer.viewContext.save()

            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func removeSuggestion(suggestion: Suggestion, completion: @escaping (ActionResult<Error>) -> Void) {
        let suggestionRequest: NSFetchRequest<CDSuggestion> = CDSuggestion.fetchRequest()
        suggestionRequest.predicate = NSPredicate(format: "name == %@", String(suggestion.name))

        do {
            guard let cdSuggestion = try CoreDataStack.persistentContainer.viewContext.fetch(suggestionRequest).first else {
                completion(.failure(CoreDataErrors.cannotFindSuggestionWithName(suggestion.name)))
                return
            }
            CoreDataStack.persistentContainer.viewContext.delete(cdSuggestion)
            try CoreDataStack.persistentContainer.viewContext.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func getSuggestion(withName name: String) -> Suggestion? {
        let suggestionRequest: NSFetchRequest<CDSuggestion> = CDSuggestion.fetchRequest()
        suggestionRequest.predicate = NSPredicate(format: "name == %@", name)

        guard let cdSuggestion = try? CoreDataStack.persistentContainer.viewContext.fetch(suggestionRequest).first else {
            return nil
        }

        return Suggestion(cdSuggestion: cdSuggestion)
    }
    
    private func defaultSuggestions() -> [Suggestion] {
        var suggestions: [Suggestion] = []

        if let path = Bundle.main.path(forResource: "suggestions", ofType: "plist"),
            let listOfSuggestions = NSArray(contentsOfFile: path) as? [String] {
        
            suggestions = listOfSuggestions.map({ (suggestionName) -> Suggestion in
                return Suggestion(name: suggestionName, creationDate: Date())
            })
        }
        
        return suggestions
    }
}
