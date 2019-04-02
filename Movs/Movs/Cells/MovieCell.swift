//
//  MovieCell.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import RxSwift

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    private let disposeBag = DisposeBag()
    
    var isFavorited: Bool = false
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    
    
    var movieViewModel: MovieViewModel! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        lbMovieTitle.text = movieViewModel.title
        //TODO: check if movie is favorited
        imgFavorite.image = isFavorited ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
        
        
        self.imgMovie.lock(duration: 0)
        self.imgMovie.image = nil
        movieViewModel.coverLocalPathObservable.subscribe(onNext: { coverLocalPath in
            guard let coverLocalPath = coverLocalPath else { return }
            
            do {
                let url = URL(fileURLWithPath: coverLocalPath)
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                self.imgMovie.image = image
            } catch {
                self.imgMovie.image = UIImage(named: "movieNegative")
                print(error)
            }
            self.imgMovie.unlock()
        }).disposed(by: disposeBag)
        
        
    }
    
}
