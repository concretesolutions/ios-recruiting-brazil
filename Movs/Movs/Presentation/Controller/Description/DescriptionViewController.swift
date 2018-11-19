//
//  MovieDescriptionViewController.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit
import CoreData

enum DescriptionBehavior {
    case Favorite
    case Normal
}

class DescriptionViewController: UIViewController {
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateAvarageLabel: UILabel!
    @IBOutlet weak var genreListLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: Class attributes
    var genresString = ""
    var result: Any?
    var behavior: DescriptionBehavior = .Normal
    // TODO: Na controller anterior popular isFavorite
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSourceSetup()
        
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        switch behavior {
        case .Favorite:
            print("Este filme já foi favoritado :)")
        // TODO: Chamar um alert avisando que o filme já foi favoritado.
        case .Normal:
            if let data = result as? Result {
                saveFavorite(data: data)
                behavior = .Favorite
                favoriteButton.setImage(UIImage(named: "@icons-favoriteSelected"), for: .normal)
            }
        }
    }
    
    func dataSourceSetup() {
        switch behavior {
        case .Favorite:
            if let data = result as? Favorite {
                movieTitleLabel.text = data.title
                rateAvarageLabel.text = "\(data.voteAverage) de 10"
                descriptionTextView.text = data.overview
                favoriteButton.setImage(UIImage(named: "@icons-favoriteSelected"), for: .normal)
                if let backdropPath = data.backdropPath {
                    setBackdropImage(backdropPath)
                }
                if let releaseDate = data.releaseDate {
                    setYearRelease(releaseDate as Date)
                }
                if let genre = data.genres {
                    genreListLabel.text = genre
                }
            } else if let data = result as? Result {
                movieTitleLabel.text = data.title
                rateAvarageLabel.text = "\(data.voteAverage ?? 0.0) de 10"
                descriptionTextView.text = data.overview
                favoriteButton.setImage(UIImage(named: "@icons-favoriteSelected"), for: .normal)
                if let backdropPath = data.backdropPath {
                    setBackdropImage(backdropPath)
                }
                if let releaseDate = data.releaseDate {
                    setYearRelease(releaseDate)
                }
                if let ids = data.genres {
                    setFormatedStringGenres(ids)
                }
            }
        case .Normal:
            guard let data = result as? Result else {return}
            movieTitleLabel.text = data.title
            rateAvarageLabel.text = "\(data.voteAverage ?? 0.0) de 10"
            descriptionTextView.text = data.overview
            favoriteButton.setImage(UIImage(named: "@icons-favoriteUnselected"), for: .normal)
            if let backdropPath = data.backdropPath {
                setBackdropImage(backdropPath)
            }
            if let releaseDate = data.releaseDate {
                setYearRelease(releaseDate)
            }
            if let ids = data.genres {
                setFormatedStringGenres(ids)
            }
        }
        
    }
    
    private func saveFavorite (data: Result) {
        let newFavorite = data.convertResultInFavorite(with: genresString)
        let persistMethod = FavoriteServices.createFavorite
        persistMethod(newFavorite) { (_, error) in
            
            
            if error != nil {
                self.behavior = .Normal
                // TODO: Trazer o behavior de erro genérico
            }
        }
    }
    
    private func setFormatedStringGenres(_ movieGenreIds: [Int]) {
        GenreServices.getGenreList { (newData, _) in
            if let genreList = newData?.list {
                let genres = genreList.filter({ (genre) -> Bool in
                    guard let id = genre.id else {return false}
                    return movieGenreIds.contains(id)
                }).map({ (genre) -> String in
                    return genre.name ?? ""
                }).joined(separator: ", ")
                let genreText = "Gen.: " + genres
                self.genreListLabel.text = genreText
                self.genresString = genreText
            }
        }
    }
    
    private func setBackdropImage(_ posterPath: String) {
        let endpoint = URL(string: APIRoute.ImageW500.rawValue + posterPath)
        let placeholder = UIImage(named: "@description-backdrop")
        backdropImage.kf.setImage(with: endpoint, placeholder: placeholder)
    }
    
    private func setYearRelease(_ date: Date) {
        let myCalendar = Calendar(identifier: .gregorian)
        let year = myCalendar.component(.year, from: date)
        releaseDateLabel.text = "Ano: \(year)"
    }
    
}
