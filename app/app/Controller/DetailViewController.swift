//
//  DetailViewController.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    weak var delegate: DetailViewControllerDelegate?
    
    var genres: [Int: String]?
    var movie: Movie?
    
    @IBOutlet weak var movieRelease: UILabel!
    @IBOutlet weak var backdrop: KFImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var favIcon: UIButton!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func viewDidLoad() {
        
        guard let movie = self.movie else { return }
        
        if let url = movie.backdropURL {
            self.backdrop.setImage(with: url, frame: self.backdrop.frame)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        if let release = movie.release {
            self.movieRelease.text = dateFormatter.string(from: release)
        } else {
            self.movieRelease.text = ""
        }
        
        if let genres = genres {
            self.movieGenres.text = movie.genreIds.map({ genreId in
                if let genre = genres[genreId] {
                    return genre
                } else {
                    return ""
                }
            }).joined(separator: ", ")
        }
        
        self.movieTitle.text = movie.title
        self.movieDescription.text = movie.description
        self.movieDescription.sizeToFit()

        self.favIcon.addTarget(self, action: #selector(self.favorite), for: .touchUpInside)
        

        if let favorite = try? CoreDataService.shared.isFavorite(movie.id) {
            if favorite {
                self.favIcon.setImage(UIImage(named: "favorite"), for: .normal)
            } else {
                self.favIcon.setImage(UIImage(named: "notFavorite"), for: .normal)
            }
        }
    }
    
    
    @objc func favorite() {
        guard let movie = self.movie else { return }
        if movie.favorite {
            
            try? CoreDataService.shared.delete(movie.id)
            self.favIcon.setImage(UIImage(named: "notFavorite"), for: .normal)

        } else {
            
            _ = try? CoreDataService.shared.insertFavorite(movie.id)
            self.favIcon.setImage(UIImage(named: "favorite"), for: .normal)
            
        }
        
        self.movie?.favorite = !movie.favorite
        self.delegate?.didChangeMovie(movie.id, !movie.favorite)
    }

}

protocol DetailViewControllerDelegate: class {
    func didChangeMovie(_ id: Int, _ favorite: Bool)
}
