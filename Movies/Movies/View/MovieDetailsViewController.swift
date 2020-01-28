//
//  MovieDetailsViewController.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 21/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let detailViewModel = MovieDetailsViewModel()
    var id: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.activityStartAnimating()
        detailViewModel.id = self.id
        loadMovie()
    }

    override func viewWillAppear(_ animated: Bool) {
        checkFavorite()
    }
    
    func checkFavorite() {
        guard let id = id else { return }
        detailViewModel.checkFavorite(id: id, completionHandler: ({ set in
            self.favoriteButton.isSelected = set
        }))
    }
    
    func loadMovie() {
        detailViewModel.requestMovie(completionHandler: { reload in
            self.configureUI()
        })
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        guard let movie = detailViewModel.getMovie() else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.dateLabel.text = self.detailViewModel.date
            self.genreLabel.text = self.detailViewModel.genres
            self.overviewTextView.text = movie.overview
            if let imagePath = movie.posterPath {
                self.movieImageView.downloaded(from: imagePath, contentMode: .scaleToFill)
            }
            self.view.activityStopAnimating()
        }
        
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        detailViewModel.favoriteAction(button: favoriteButton, completionHandler: { select in
            self.favoriteButton.isSelected = select
        })
    }
    
    
}
