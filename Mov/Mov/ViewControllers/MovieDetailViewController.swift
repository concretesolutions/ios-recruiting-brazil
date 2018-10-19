//
//  MovieDetailViewController.swift
//  Mov
//
//  Created by Allan on 13/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class MovieDetailViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var movie: Movie!
    private var items = [TableViewItem]()
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupInterface() {
        super.setupInterface()
        currentTitle = "Movie"
        tableView.register(UINib(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverTableViewCell")
        tableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "SimpleTableViewCell")
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 55.0
        tableView.rowHeight = UITableView.automaticDimension
        processMovieData()
    }
    
    //MARK: - Methods
    
    private func processMovieData(){
        let cover = TableViewItem(type: .cover, text: nil, imageURL: movie.imageURL)
        let title = TableViewItem(type: .simple, text: movie.title, isFavorite: movie.isMyFavorite)
        
        items.append(cover)
        items.append(title)
        
        if let releaseYear = movie.releaseDate.year{
            let year = TableViewItem(type: .simple, text: releaseYear)
            items.append(year)
        }
        
        if !movie.genres.isEmpty{
            let genres = TableViewItem(type: .simple, text: movie.genreList)
            items.append(genres)
        }
        
        let text = TableViewItem(type: .text, text: movie.overview)
        items.append(text)
        
        tableView.reloadData()
    }

}

//MARK: - TableView DataSource, Delegate

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117.0
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.type.rawValue, for: indexPath) as! MovieDetailTableViewCell
        cell.setup(with: item, movie: movie, withDelegate: self)
        return cell
    }
}

//MARK: - MovieCollectionViewCellDelegate
extension MovieDetailViewController: FavoriteMovieDelegate{
    func didAddedToFavorite(movie: Movie) {
        FavoriteController.shared.add(favorite: movie, postNotification: true)
    }
    func didRemovedFromFavorite(movie: Movie) {
        FavoriteController.shared.remove(favorite: movie, postNotification: true)
    }
}
