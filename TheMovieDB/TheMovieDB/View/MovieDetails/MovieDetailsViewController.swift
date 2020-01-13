//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 12/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    public var movie: Movie?
    private var detailView = MovieDetailView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigation()
        guard let movie = self.movie else { return }
        detailView.fillView(withMovie: movie)
        view.addSubview(detailView)
        detailView.autolayoutSuperView()
    }
        
    private func styleNavigation() {
        self.title = NSLocalizedString("Details", comment: "Title Movie Details")
    }
}
