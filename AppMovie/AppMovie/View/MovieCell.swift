//
//  MovieCell.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import Kingfisher

//protocol MovieCellDelegate {
//    func presentDetailMovieView(withMovie movie: Result)
//}

class MovieCell: UICollectionViewCell {
   // var delegate: MovieCellDelegate?
    
    //Mark: - Properties
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var bkgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    
    
    
    var movie: Result? {
        didSet{
            titleLabel.text = movie?.title
            movieImage.kf.indicatorType = .activity
            let stringImage = movie!.poster_path
            let Image = "\(URL_IMG)\(stringImage)" ?? ""
            if let image = URL(string: Image){
                movieImage.kf.indicatorType = .activity
                movieImage.kf.setImage(with: image)
            }
        }
    }
    
    lazy var titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainDarkBlue()
        view.addSubview(titleLabel)
        titleLabel.center(inView: view)
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.groupTableViewBackground
        iv.contentMode = .scaleToFill
        //scaleAspectFit
        return iv
    }()
    
    let ttlLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainColor()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 16.0)
        label.text = "Thor"
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton() // let preferred over var here
        button.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        //        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here
       // configureViewComponents()
    }
    
    // MARK: - Selectors
    
//    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
//        print("Handle Press...")
//        guard let movie = self.movie else { return }
//        if sender.state == .began {
//            delegate?.presentDetailMovieView(withMovie: movie)
//        }
//    }
    
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
//        self.clipsToBounds = true
//        
//        
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        self.addGestureRecognizer(longPressGesture)
//        
    }
    

    
    
//    var ImageFavorite : UIImage = UIImage.init(named: "IconFavoriteFull")!.withRenderingMode(.alwaysTemplate)
//
//    func setupLayout(favorite : Bool) {
//
//        self.layoutIfNeeded()
//
//        self.backgroundColor = UIColor.white
//
//        bkgView.backgroundColor = UIColor.mainDarkBlue()
//
//        titleLabel.textColor = UIColor.mainColor()
//        titleLabel.text = ""
//
//        movieImage.backgroundColor = UIColor.mainColor()
//        movieImage.image = nil
//
//        favoriteImage.backgroundColor = UIColor.clear
//        favoriteImage.image = ImageFavorite
//
//        if (favorite) {
//            favoriteImage.tintColor = UIColor.mainColor()
//        }else{
//            favoriteImage.tintColor = UIColor.mainWhite()
//        }
//
//    }
    
}
