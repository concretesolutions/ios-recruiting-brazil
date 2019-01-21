//
//  FavoriteCell.swift
//  Movs
//
//  Created by Franclin Cabral on 1/20/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit
import AlamofireImage

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var dropbackImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(movie: Movie) {
        dropbackImage.af_setImage(withURL: URL(string: movie.backdropPath)!)
        movieTitle.text = movie.title
        let releaseComponentes = movie.releaseDate.split { $0 == "-"}
        if let releaseYear = releaseComponentes.first {
            year.text = String(releaseYear)
        }else {
            year.text = ""
        }
        genres.text = self.getGenres(movie.genreIds)
    }
    
    func getGenres(_ genresId: [Int]) -> String {
        let dataStore = ManagerCenter.shared.factory.dataStore
        let genres = dataStore.read(Genre.self, matching: nil)
        let genresInUse = genres.filter{ genresId.contains($0.id) }
        let names = genresInUse.map { $0.name }
        return names.joined(separator: ", ")
    }

}
