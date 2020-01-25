//
//  MovieDetailsViewController.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 21/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let detailViewModel = MovieDetailsViewModel()
    var id: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let coreData = CoreData()
        let movie = coreData.getElementCoreData(id: id!)
        
        view.activityStartAnimating()
        detailViewModel.id = self.id
        loadMovie()
    }

    override func viewWillAppear(_ animated: Bool) {
        print(UserDefaults.standard.array(forKey: "favoritesIds"))
    }
    func loadMovie() {
        detailViewModel.requestMovie(completionHandler: { reload in
            self.configureUI()
        
        })
    }
    
    private func configureUI() {
        guard let movie = detailViewModel.getMovie() else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.dateLabel.text = movie.releaseDate
//          generos
            self.overviewTextView.text = movie.overview
            self.movieImageView = self.detailViewModel.imageView
            self.view.activityStopAnimating()
        }
        
    }
}
