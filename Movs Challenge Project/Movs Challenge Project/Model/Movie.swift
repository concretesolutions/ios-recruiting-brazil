//
//  Movie.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 16/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import CoreData

class Movie: Decodable, Hashable {
    // Static Properties
    
    static let didDownloadPosterImageNN = Notification.Name(rawValue: "com.concrete.Movs-Challenge-Project.Movie.didDownloadPosterImageNN")
    static let didDownloadBackdropImageNN = Notification.Name(rawValue: "com.concrete.Movs-Challenge-Project.Movie.didDownloadBackdropImageNN")
    
    static let favoriteInformationDidChangeNN = Notification.Name(rawValue: "com.concrete.Movs-Challenge-Project.Movie.favoriteInformationDidChangeNN")
    
    // Static Methods
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    // Public Types
    
    enum MovieError: Error {
        case initError
    }
    
    // Public Properties
    
    let id: Int
    let title: String
    let releaseDate: Date?
    let genreIds: [Int]
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    
    var isFavorite: Bool = false {
        didSet {
            saveFavoriteInfo()
            NotificationCenter.default.post(name: Movie.favoriteInformationDidChangeNN, object: self)
        }
    }
    
    var posterImage: UIImage? {
        if privatePosterImage == nil {
            fetchPosterImage()
        }
        return privatePosterImage
    }
    
    var backdropImage: UIImage? {
        if privateBackdropImage == nil {
            fetchBackdropImage()
        }
        return privateBackdropImage
    }
    
    var popularIndex: Int? = nil
    var searchIndex: Int? = nil
    
    // Public Methods
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    // Initialisation/Lifecycle Methods
    
    init(profile: NSManagedObject) throws {
        guard
            let id = profile.value(forKey: "id") as? Int,
            let title = profile.value(forKey: "title") as? String,
            let genreIds = profile.value(forKey: "genres") as? [Int],
            let overview = profile.value(forKey: "overview") as? String,
            let isFav = profile.value(forKey: "isFavorite") as? Bool
        else { throw MovieError.initError }
        
        self.id = id
        self.title = title
        self.releaseDate = profile.value(forKey: "releaseDate") as? Date
        self.genreIds = genreIds
        self.overview = overview
        self.backdropPath = profile.value(forKey: "backdropPath") as? String
        self.posterPath = profile.value(forKey: "posterPath") as? String
        self.isFavorite = isFav
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        releaseDate = dateFormatter.date(from: dateString)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        overview = try container.decode(String.self, forKey: .overview)
        backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        posterPath = try container.decode(String?.self, forKey: .posterPath)
        
        getFavoriteInfo()
    }
    
    // Override Methods
    // Private Types
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case overview = "overview"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
    
    // Private Properties
    
    private var privatePosterImage: UIImage? = nil
    private var privateBackdropImage: UIImage? = nil
    
    // Private Methods
    
    private func fetchPosterImage() {
        guard let path = self.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w342" + path) else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                if response == nil {
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                        self.fetchPosterImage()
                    }
                }
                return
            }
            self.privatePosterImage = image
            NotificationCenter.default.post(name: Movie.didDownloadPosterImageNN, object: self)
        }
        task.resume()
    }
    
    private func fetchBackdropImage() {
        guard let path = self.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w780" + path) else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                if response == nil {
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                        self.fetchBackdropImage()
                    }
                }
                return
            }
            self.privateBackdropImage = image
            NotificationCenter.default.post(name: Movie.didDownloadBackdropImageNN, object: self)
        }
        task.resume()
    }
    
    private func getFavoriteInfo() {
        DispatchQueue.main.async {
            guard
                let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            else { return }
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
            
            do {
                if let profile = try context.fetch(request).first(where: { (object) -> Bool in
                    object.value(forKey: "id") as? Int ?? 0 == self.id
                }), let isFav = profile.value(forKey: "isFavorite") as? Bool {
                    self.isFavorite = isFav
                }
            }
            catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    private func saveFavoriteInfo() {
        DispatchQueue.main.async {
            guard
                let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
                let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context)
            else { return }
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
            
            do {
                if let profile = try context.fetch(request).first(where: { (object) -> Bool in
                    object.value(forKey: "id") as? Int ?? 0 == self.id
                }) {
                    if !self.isFavorite {
                        context.delete(profile)
                    }
                }
                else {
                    let profile = NSManagedObject(entity: entity, insertInto: context)
                    profile.setValue(self.id, forKey: "id")
                    profile.setValue(self.isFavorite, forKey: "isFavorite")
                    profile.setValue(self.genreIds, forKey: "genres")
                    profile.setValue(self.title, forKey: "title")
                    profile.setValue(self.overview, forKey: "overview")
                    profile.setValue(self.releaseDate, forKey: "releaseDate")
                    profile.setValue(self.posterPath ?? "", forKey: "posterPath")
                    profile.setValue(self.backdropPath ?? "", forKey: "backdropPath")
                }
                
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
