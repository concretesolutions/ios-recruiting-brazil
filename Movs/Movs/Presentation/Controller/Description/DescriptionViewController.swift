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
    
    /// Class attributes
    var genresString = ""
    var data: Any?
    var behavior: DescriptionBehavior = .Normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataSourceSetup()
        super.viewWillAppear(animated)
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        switch behavior {
        case .Favorite:
            self.customAlert(title: "Favorito", message: "Você já favoritou este filme.", actionTitle: "Ok")
        case .Normal:
            if let data = data as? Result {
                saveFavorite(data: data)
                behavior = .Favorite
                favoriteButton.setImage(UIImage(named: "@icons-favoriteSelected"), for: .normal)
            }
        }
    }
    
}

// MARK: Data setup
extension DescriptionViewController {
    //swiftlint:disable cyclomatic_complexity
    func dataSourceSetup() {
        switch behavior {
        case .Favorite:
            /// It is possible retrieve a favorite behavior from Favorite or Result instance
            if let favorite = data as? Favorite {
                movieTitleLabel.text = favorite.title
                rateAvarageLabel.text = "\(favorite.voteAverage) de 10"
                descriptionTextView.text = favorite.overview
                favoriteButton.setImage(UIImage(named: "@icons-favoriteSelected"), for: .normal)
                if let backdropPath = favorite.backdropPath {
                    setBackdropImage(backdropPath)
                }
                if let releaseDate = favorite.releaseDate {
                    setYearRelease(releaseDate as Date)
                }
                if let genre = favorite.genres {
                    genreListLabel.text = genre
                }
            } else if let result = data as? Result {
                movieTitleLabel.text = result.title
                rateAvarageLabel.text = "\(result.voteAverage ?? 0.0) de 10"
                descriptionTextView.text = result.overview
                favoriteButton.setImage(UIImage(named: "@icons-favoriteSelected"), for: .normal)
                if let backdropPath = result.backdropPath {
                    setBackdropImage(backdropPath)
                }
                if let releaseDate = result.releaseDate {
                    setYearRelease(releaseDate)
                }
                if let ids = result.genres {
                    setFormatedStringGenres(ids)
                }
            }
            
        /// To normal behavior is just necessary a Result instance
        case .Normal:
            guard let result = data as? Result else {return}
            movieTitleLabel.text = result.title
            rateAvarageLabel.text = "\(result.voteAverage ?? 0.0) de 10"
            descriptionTextView.text = result.overview
            favoriteButton.setImage(UIImage(named: "@icons-favoriteUnselected"), for: .normal)
            if let backdropPath = result.backdropPath {
                setBackdropImage(backdropPath)
            }
            if let releaseDate = result.releaseDate {
                setYearRelease(releaseDate)
            }
            if let ids = result.genres {
                setFormatedStringGenres(ids)
            }
        }
    }
    
    //swiftlint:enable cyclomatic_complexity
    private func saveFavorite (data: Result) {
        let newFavorite = data.convertResultInFavorite(with: genresString)
        let persistMethod = FavoriteServices.createFavorite
        persistMethod(newFavorite) { (_, _) in
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
                self.genreListLabel.text = genres
                self.genresString = genres
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
