//
//  MovieDetailTableViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 21/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable

class MovieDetailTableViewController: UITableViewController {
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
    }
    
    init(movie: Movie, style: UITableView.Style) {
        self.movie = movie
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(){
        tableView.allowsSelection = false
        tableView.register(cellType: MoviePosterTableViewCell.self)
        tableView.register(cellType: DescriptionTableViewCell.self)
    }
    
}

//MARK:- Data Source
extension MovieDetailTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}

//MARK:- Delegate
extension MovieDetailTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let posterCell = tableView.dequeueReusableCell(for: indexPath, cellType: MoviePosterTableViewCell.self)
        let descriptionCell = tableView.dequeueReusableCell(for: indexPath, cellType: DescriptionTableViewCell.self)
        switch indexPath.row {
        case 0:
            posterCell.setup(posterImage: movie.poster ?? UIImage(named: "errorIcon")!)
            return posterCell
        case 1:
            descriptionCell.setup(movieDetail: movie.title)
            return descriptionCell
        case 2:
            descriptionCell.setup(movieDetail: movie.releaseYear)
            return descriptionCell
        case 3:
            //FIXME: create logic to pass genres
            descriptionCell.setup(movieDetail:"genre")
            return descriptionCell
        case 4:
            descriptionCell.setup(movieDetail:movie.overview)
            return descriptionCell
        default:
            return UITableViewCell()
        }
    }
}
