//
//  MovieDescriptionViewController.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateAvarageLabel: UILabel!
    @IBOutlet weak var genreListLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: Class attributes
    var result: Result?

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
    
    private func setFormatedStringGenres(_ movieGenreIds: [Int]) {
        GenreServices.getGenreList { (newData, _) in
            if let genreList = newData?.list {
                let genres = genreList.filter({ (genre) -> Bool in
                    guard let id = genre.id else {return false}
                    return movieGenreIds.contains(id)
                }).map({ (genre) -> String in
                    return genre.name ?? ""
                }).joined(separator: ", ")
                self.genreListLabel.text = "Gêneros: " + genres
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
        releaseDateLabel.text = "Ano de lançamento: \(year)"
    }
}
