//
//  MovieDetailController.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {
    
    // MARK: - Attributes
    var screen: MovieDetailScreen
    
    // MARK: - Initializers
    required init(movie: Movie) {
        self.screen = MovieDetailScreen(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
