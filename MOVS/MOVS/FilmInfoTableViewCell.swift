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
    }
    
    @IBAction func FavoriteFilm(_ sender: UIButton) {
        
    }
}
