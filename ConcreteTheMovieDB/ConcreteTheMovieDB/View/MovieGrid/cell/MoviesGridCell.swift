//
//  MoviesGridCell.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 13/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit

class MoviesGridCell: UICollectionViewCell {
    
    @IBOutlet weak var oBannerView: UIImageView!
    @IBOutlet weak var oMovieTitle: UILabel!
    @IBOutlet weak var oFavoriteButton: UIButton!
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //fixme: movie?
    func get(ofCollectionView collectionView:UICollectionView, withMovie movie: Movie?, for indexPath:IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.movieGridCell, for: indexPath) as? MoviesGridCell else {
            return UICollectionViewCell()
        }
        cell.oMovieTitle.text = movie?.original_title
        cell.movie = movie
        
         cell.oFavoriteButton.setImage(UIImage(named: "favorite_gray_icon")!, for: .normal)
        
        let favoriteMovies = CoreDataManager.retriveData()
        guard let movie = movie else {return UICollectionViewCell()}
        for favoriteMovie in favoriteMovies {
            if movie.id == favoriteMovie.id{
                cell.oFavoriteButton.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
            }
        }
        
        if let posterPath = movie.poster_path {
            APIRequest.getMovieBanner(inPath: posterPath) { (response) in
                switch response {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.oBannerView.image = image
                    }
                case .error(let error):
                    print(error)
                    break
                }
            }
        }else{
            cell.oBannerView.image = UIImage(named: "Splash")
        }
        
        
        return cell
    }
    
    @IBAction func addToFavoritePressed(_ sender: Any) {
        oFavoriteButton.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
        guard let movie = movie else {return}
        CoreDataManager.createData(movie: movie)
    }
    
}
