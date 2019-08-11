//
//  MovieSearchCollectionViewDelegate.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 11/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

final class MovieSearchCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: MovieSelectionDelegate?
    
    let movies: [Result]
    
    init(movies: [Result], delegate: MovieSelectionDelegate) {
        self.movies = movies
        self.delegate = delegate
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30.0) / 2.0
        let height = width * 1.6
        
        return CGSize.init(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    //    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //
    //        if (self.currentYear != nil || self.currentGenre != nil){
    //            return CGSize.init(width: collectionView.frame.size.width, height: 40.0)
    //        }else{
    //            return CGSize.zero
    //        }
    //    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieCell = movies[indexPath.row]
        delegate?.didSelect(movie: movieCell)
        //self.performSegue(withIdentifier: "toDetail", sender: movieCell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == movie.count - 8 && !isLoading && pageCount <= totalPages {
//            pageCount += 1
//            loadMovies()
//        }
        print("WillDisplay")
    }
    
}
