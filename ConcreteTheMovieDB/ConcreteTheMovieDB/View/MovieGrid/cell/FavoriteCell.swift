//
//  FavoriteCell.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 23/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var oMovieBanner: UIImageView!
    @IBOutlet weak var oMovieTitle: UILabel!
    @IBOutlet weak var oMovieYear: UILabel!
    @IBOutlet weak var oMovieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func get(ofTableView tableView:UITableView, for indexPath: IndexPath, movie: Movie) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.favoriteCell, for: indexPath) as? FavoriteCell else {
            print("Failed to get FavoriteCell reusable cell")
            return UITableViewCell(frame: .zero)
        }
      
        cell.oMovieYear.text = movie.release_date.prefix(4).description
        cell.oMovieTitle.text = movie.original_title
        cell.oMovieDescription.text = movie.overview
        //FIXME: refactor
        
        if let posterPath = movie.poster_path {
            APIRequest.getMovieBanner(inPath: posterPath) { (response) in
                switch response {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.oMovieBanner.image = image
                    }
                case .error(let error):
                    print(error)
                    break
                }
            }
        }else{
            cell.oMovieBanner.image = UIImage(named: "Splash")
        }
        
        return cell
    }

}
