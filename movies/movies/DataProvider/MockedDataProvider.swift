//
//  MockedDataProvider.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

class MockedDataProvider: DataProvidable {
    public static let shared = MockedDataProvider()
    
    var popularMoviesPublisher = CurrentValueSubject<[Movie], Error>([])
    var favoriteMoviesPublisher = CurrentValueSubject<[Movie], Error>([])
    
    var popularMovies: [Movie] {
        return self.popularMoviesPublisher.value
    }
    
    var favoriteMovies: [Movie] {
        return self.favoriteMoviesPublisher.value
    }
    
    private var favoriteIds = [0]
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    init() {
        // Initializing movies
        let movies = [
            Movie(id: 0,
                  title: "The Little Mermaid",
                  posterPath: nil,
                  overview: "This colorful adventure tells the story of an impetuous mermaid princess named Ariel who falls in love with the very human Prince",
                  releaseDate: dateFormatter.date(from: "1989-12-12"),
                  genreIds: [0]),
            Movie(id: 1,
                  title: "The Princess and the Frog",
                  posterPath: nil,
                  overview: "A waitress, desperate to fulfill her dreams as a restaurant owner, is set on a journey to turn a frog prince back into a human being",
                  releaseDate: dateFormatter.date(from: "2009-12-12"),
                  genreIds: [0]),
            Movie(id: 2,
                  title: "Tangled",
                  posterPath: nil,
                  overview: "When the kingdom's most wanted-and most charming-bandit Flynn Rider hides out in a mysterious tower, he's taken hostage by Rapunzel",
                  releaseDate: dateFormatter.date(from: "2010-12-12"),
                  genreIds: [0, 1]),
            Movie(id: 3,
                  title: "Moana",
                  posterPath: nil,
                  overview: "In Ancient Polynesia, when a terrible curse incurred by Maui reaches an impetuous Chieftain's daughter's island",
                  releaseDate: dateFormatter.date(from: "2016-12-12"),
                  genreIds: [1, 2])
        ]
        
        popularMoviesPublisher.send(movies)
        favoriteMoviesPublisher.send(movies.filter { isFavorite($0.id) })
    }
    
    func toggleFavorite(withId id: Int) {
        if let idIndex = favoriteIds.firstIndex(of: id) { // Check if given id is on favorites array
            self.favoriteIds.remove(at: idIndex)
            
        } else { // Given id is not on favorites array, so add to it
            self.favoriteIds.append(id)
        }
    }
    
    func isFavorite(_ id: Int) -> Bool {
        return self.favoriteIds.contains(id)
    }
}
