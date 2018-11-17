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
                setYearRelease(date: releaseDate)
            }
            getFormatedStringGenres(ids: data.genres)
        }
    }
    
    // TODO: Tirar essa busca dos gêneros daqui e fazer uma única busca ao listar todos os filmes... pensar a respeito!
    private func getFormatedStringGenres(ids: [Int]?) {
        GenreServices.getGenreList { (genreList, _) in
            if let arrayData = genreList?.list,
                let idsList = ids {
                let genres = arrayData.filter({ (genre) -> Bool in
                    return idsList.contains(genre.id!)
                }).map({ (a) -> String in
                    return a.name!
                })
                let genreMessage = "Gêneros: \(genres.joined(separator: ", "))"
                self.genreListLabel.text = genreMessage
            }
        }
    }
    
    private func setBackdropImage(_ posterPath: String) {
        let endpoint = URL(string: APIRoute.ImageW500.rawValue + posterPath)
        let placeholder = UIImage(named: "@description-backdrop")
        backdropImage.kf.setImage(with: endpoint, placeholder: placeholder)
    }
    
    private func setYearRelease(date: Date) {
        let myCalendar = Calendar(identifier: .gregorian)
        let year = myCalendar.component(.year, from: date)
        releaseDateLabel.text = "Ano de lançamento: \(year)"
    }

}
