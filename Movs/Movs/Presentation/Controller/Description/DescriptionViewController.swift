//
//  MovieDescriptionViewController.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit
import CoreData

class DescriptionViewController: UIViewController {
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateAvarageLabel: UILabel!
    @IBOutlet weak var genreListLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: Class attributes
    var genresString = ""
    var result: Result?
    // TODO: Na controller anterior popular isFavorite
    var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = result {
            movieTitleLabel.text = data.title
            rateAvarageLabel.text = "\(data.voteAverage ?? 0.0) de 10"
            descriptionTextView.text = data.overview
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
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        switch isFavorite {
        case true:
            print("Este filme já foi favoritado :)")
        // TODO: Chamar um alert avisando que o filme já foi favoritado.
        case false:
            if let data = result {
                saveFavorite(data: data)
            }
        }
    }
    
    private func saveFavorite (data: Result) {
        let newFavorite = data.favoriteConverter(with: genresString)
        let persistMethod = FavoriteServices.createFavorite
        persistMethod(newFavorite) { (_, error) in
            self.isFavorite = true
            if error != nil {
            self.isFavorite = false
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
