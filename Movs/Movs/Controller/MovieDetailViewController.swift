//
//  MovieViewTableViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 19/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import Reusable

class MovieTableViewController: UITableViewController {

    //MARK: - Properties
    var movie: Movie
    var db = RealmManager.shared
    
    //MARK: Initializers
    init(movie: Movie, style: UITableView.Style = UITableView.Style.plain) {
        self.movie = movie
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
    }

    //MARK: - Setup
    func registerCells() {
        tableView.register(cellType: ThumbnailTableViewCell.self)
        tableView.register(cellType: DetailTableViewCell.self)
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            //FIXME: placeholer image
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ThumbnailTableViewCell.self)
            cell.setup(thumbImage: movie.thumbnail!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DetailTableViewCell.self)
            cell.setup(withText: movie.title, withButton: true, withSeparator: true, delegate: self, isFavourite: movie.isFavourite)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DetailTableViewCell.self)
            cell.setup(withText: movie.releaseYear, withSeparator: true)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DetailTableViewCell.self)
            cell.setup(withText: movie.genresText(), withSeparator: true)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DetailTableViewCell.self)
            cell.setup(withText: movie.overview)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.height * 0.4
        case 1:
            return movie.title.height(withConstrainedWidth: UIScreen.main.bounds.width - 80, font: UIFont.systemFont(ofSize: 17)) + 20
        case 2:
            return movie.releaseYear.height(withConstrainedWidth: UIScreen.main.bounds.width - 40, font: UIFont.systemFont(ofSize: 17)) + 20
        case 3:
            return movie.genresText().height(withConstrainedWidth: UIScreen.main.bounds.width - 40, font: UIFont.systemFont(ofSize: 17)) + 20
        case 4:
            return movie.overview.height(withConstrainedWidth: UIScreen.main.bounds.width - 40, font: UIFont.systemFont(ofSize: 17)) + 20
        default:
            break
        }
        return 30
    }

}

extension MovieTableViewController: FavouriteCellButtonDelegate {
    
    func didPressButton(withFavouriteStatus isFavourite: Bool) {
        if isFavourite {
            db.create(movie.rlm())
            print("Created on Realm")
        } else {
            if let deleteMovie = db.get(MovieRlm.self, withPrimaryKey: movie.id) {
                db.delete(deleteMovie)
                print("Deleted from Realm")
            }
        }
    }
    
}

