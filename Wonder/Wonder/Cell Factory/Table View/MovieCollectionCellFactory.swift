//
//  MovieCollectionCellFactory.swift
//  Wonder
//
//  Created by Marcelo on 12/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionCellFactory {
    func moviewCollectionCell(indexPath: IndexPath, collectionView: UICollectionView, movie: Results, isHidden: Bool) -> MoviesCollectionCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MoviesCollectionCell
        
        cell.movieTitle.text = movie.title
        cell.movieFavoriteBackgroundView.isHidden = isHidden
        
        if (!movie.poster_path.isEmpty && movie.poster_path != "" ) {
            let webService = WebService()
            let imgSrc = webService.getFullUrl(movie.poster_path)
            let url = URL(string: imgSrc)
            if imgSrc.isEmpty {
                cell.movieImageView?.contentMode = UIView.ContentMode.scaleAspectFill
                cell.movieImageView?.image = UIImage(named: "noContentIcon")
            }else{
                cell.movieImageView?.kf.indicatorType = .activity
                cell.movieImageView?.kf.setImage(with: url)
            }
        }else{
            cell.movieImageView?.contentMode = UIView.ContentMode.scaleAspectFill
            cell.movieImageView?.image = UIImage(named: "noContentIcon")
        }
        return cell
    }
}
