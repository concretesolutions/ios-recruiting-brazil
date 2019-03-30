//
//  MovieViewModel.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import RxSwift
import RxCocoa

class MovieViewModel {
    //MARK: Variables
    private let movie: Movie
    private var coverLocalPath = BehaviorRelay<String?>(value: nil)
    
    
    //MARK: - RXObservable
    var coverLocalPathObservable: Observable<String?> {
        return coverLocalPath.asObservable()
    }
    
    //MARK: - Init
    init(_ movie: Movie) {
        self.movie = movie
        
        loadCover()
    }
    
    //MARK: - Load cover image
    private func loadCover() {
        guard let url = movie.coverPath else {
            self.coverLocalPath.accept("")
            return
        }
        
        let name = url.replacingOccurrences(of: "/", with: "_")
        
        var filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        filePath = filePath.appendingPathComponent(name)
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            self.coverLocalPath.accept(filePath.relativePath)
        } else {
            APIClient.dataFrom(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        try data.write(to: filePath, options: .atomic)
                        self?.coverLocalPath.accept(filePath.path)
                    } catch {
                        print("Unable to write data: \(error)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Movie properties
    var id: Int {
        return movie.id
    }
    
    var title: String {
        return movie.title
    }
    
    var description: String {
        return movie.overview!
    }
    
    var releaseDate: String {
        return movie.releaseDate
    }
    
    var categories: String {
        var categories: String = ""
        
        for category in movie.genre {
            categories = (categories == "") ? Genre.getGenreBy(id: category)
                : categories + ", " + Genre.getGenreBy(id: category)
        }
        
        return categories
    }
}
