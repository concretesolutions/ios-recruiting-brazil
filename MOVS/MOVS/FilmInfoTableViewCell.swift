//
//  FilmInfoTableViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmInfoTableViewCell: UITableViewCell, FilmCell {

    @IBOutlet weak var outletTitleLabel: UILabel!
    @IBOutlet weak var outletYearLabel: UILabel!
    @IBOutlet weak var outletGenresLabel: UILabel!
    @IBOutlet weak var outletFavoriteButton: UIButton!
    
    var genres:[Gener]?
    var film: ResponseFilm?
    
    //var film: ResponseFilm
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(withFilm film: ResponseFilm) {
        self.film = film
        if let releaseYear = film.release_date?.split(separator: "-").first {
            self.outletYearLabel.text = String(releaseYear)
        }else{
            self.outletYearLabel.text = film.release_date
        }
        self.outletTitleLabel.text = film.title
        var genresLabel: String = ""
        NetworkManager.shared.fetchGenres { (result) in
            switch result{
            case .success(let genres):
                guard let genresInAPI = genres.genres else {
                    print("Error, API with no genres in: \(FilmInfoTableViewCell.self)")
                    return
                }
                guard let filmGenresID = film.genres else {
                    print("Error, film with no genres in: \(FilmInfoTableViewCell.self)")
                    return
                }
                let filmGenres = genresInAPI.filter({ (genre) -> Bool in
                    return filmGenresID.contains(Int(genre.id))
                })
                
                self.genres = filmGenres
                for genre in filmGenres {
                    if let name = genre.name {
                        genresLabel += "\(name), "
                    }
                }
                DispatchQueue.main.async {
                    self.outletGenresLabel.text = String(genresLabel.dropLast(2))
                }
            case .failure(let error):
                print("Error \(error.localizedDescription) in: \(FilmInfoTableViewCell.self)")
            }
        }
        
        
        if let id = film.id {
            if CoreDataManager<Film>().exist(predicate: NSPredicate(format: "id = %@", "\(id)")){
                self.outletFavoriteButton.tintColor = PaletColor.pink.rawValue
            }
        }
    }
    
    @IBAction func FavoriteFilm(_ sender: UIButton) {
        if let film = self.film {
            let coreDataFilmManager = CoreDataManager<Film>()
            if let id = film.id {
                if !coreDataFilmManager.exist(predicate: NSPredicate(format: "id = %@", "\(id)")){
                    let newFilm = Film(id: id, overview: film.overview, posterPath: film.poster_path, releaseDate: film.release_date, title: film.title, genres: self.genres)
                    coreDataFilmManager.insert(object: newFilm)
                    
                    UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
                        sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        sender.tintColor = PaletColor.pink.rawValue
                    }) { (_) in
                        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                            sender.transform = CGAffineTransform.identity
                        }, completion: { (_) in
                            
                        })
                        
                    }
                }
            }
        }
    }
}
