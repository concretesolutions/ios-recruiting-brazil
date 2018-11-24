//
//  MovieDetailsTableViewController.swift
//  Movs
//
//  Created by Julio Brazil on 23/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {
    var movie: CodableMovie
    
    init(presenting movie: CodableMovie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        self.title = "Movie"
        self.tableView.contentInset = .zero
        self.tableView.layoutMargins = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "Movie"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.row {
        case 0:
            cell = ImageTableViewCell()
            if let url = URL(string: TMDBManager.imageEndpoint + (movie.poster_path ?? "")) {
                cell.imageView?.sd_setImage(with: url)
            }
        case 1:
            cell.textLabel?.text = movie.title
        case 2:
            cell.textLabel?.text = movie.release_date
        case 3:
            let names = TMDBManager.shared.genreNames(forIds: movie.genre_ids)
            cell.textLabel?.text = names.joined(separator: ", ")
        case 4:
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = movie.overview
        default:
            fatalError("tried to acces row \(indexPath.row), which does not exist")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (UIScreen.main.bounds.width - 32) * (3/2)
        } else {
            return self.tableView.rowHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
