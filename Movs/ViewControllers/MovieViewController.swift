//
//  MovieViewController.swift
//  Movs
//
//  Created by Filipe Merli on 21/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    //MARK: Properties
    private var viewModel: MoviesViewModel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var categLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var descriptionTextLabel: UITextView!
    var movieTitle = ""
    var posterUrl = ""
    var descripText = ""
    var yearNum = ""
    var catTex = ""
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    //MARK: ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        configView()
        
        
    }
    func configView() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        movieTitleLabel.text = movieTitle
        yearLabel.text = yearNum
        categLabel.text = catTex
        descriptionTextLabel.text = descripText
        if (posterUrl == "") {
            moviePoster.image = #imageLiteral(resourceName: "placeholder")
        } else{
            moviePoster.loadImageWithUrl(posterUrl: posterUrl) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    print("Erro ao baixar imagem: \(error.reason)")
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.moviePoster.image = response.banner
                    }
                }
            }
        }
        
    }
}
