//
//  MovieDetailController.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 10/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    var movieDetailView = MovieDetailView()
    var moviePosterUrl: String = ""
    var movieName: String = ""
    var movieOverview: String = ""
    var movieGenres:[String] = [ ]
    
    override func viewDidLoad() {
        setupView()
        print(String(describing: movieGenres))
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let vf = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 750)
        movieDetailView = MovieDetailView(frame: vf)
        let sv = UIScrollView(frame: self.view.frame)
        sv.contentSize.height = 755
        self.view.addSubview(sv)
        sv.addSubview(movieDetailView)
        movieDetailView.moviePosterView.loadImage(urlString: "https://image.tmdb.org/t/p/w500/" + moviePosterUrl)
        movieDetailView.movieNameLabel.text = movieName
        movieDetailView.movieDetailLabel.attributedText = showMovieInfo(overview: movieOverview,genres:movieGenres)
    }
    
    func showMovieInfo(overview:String, genres:[String]) -> NSMutableAttributedString{
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "Overview\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.black]))
        attributedText.append(NSAttributedString(string: overview + "\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.gray]))
        attributedText.append(NSAttributedString(string: "Genres\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.black]))
        let x = String(describing: genres).replacingOccurrences(of: "\"", with: "")
        let y = x.replacingOccurrences(of: "[", with: "")
        let z = y.replacingOccurrences(of: "]", with: "")
        attributedText.append(NSAttributedString(string: z + "\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.gray]))
        return attributedText
    }
    
}
