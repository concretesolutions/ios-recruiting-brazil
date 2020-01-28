//
//  DetailMovieViewController.swift
//  movs
//
//  Created by Isaac Douglas on 26/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie?
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTableView()
        
        guard let movie = self.movie else { return }
        self.imageView.image = movie.image
        self.navigationItem.title = movie.title
        
        let genres = Genres.shared?.genres
            .filter({ genre in movie.genreIDS.contains(genre.id) })
            .map({ genre in genre.name })
            .joined(separator: ", ")
        
        self.items.append(movie.title)
        
        if let date = movie.releaseDate.date {
            let year = Calendar.current.component(.year, from: date)
            self.items.append("\(year)")
        }
        
        if let genres = genres {
            self.items.append(genres)
        }
        
        self.items.append(movie.overview)
        
        let favorite = DataManager().isFavorite(movie: movie)
        let text = favorite ? Localizable.unfavorite : Localizable.favorite
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: text, style: .done, target: self, action: #selector(self.favoriteAction))
    }
    
    @objc internal func favoriteAction() {
        guard let movie = self.movie else { return }
        
        let dataManager = DataManager()
        let favorite = dataManager.isFavorite(movie: movie)
        
        if favorite {
            dataManager.delete(movie)
        } else {
            dataManager.save(movie)
        }
        
        guard let rightBarButtonItem = self.navigationItem.rightBarButtonItem else { return }
        let text = !favorite ? Localizable.unfavorite : Localizable.favorite
        rightBarButtonItem.title = text
    }
    
}

extension DetailMovieViewController {
    
    internal func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.addFooterView()
        self.tableView.register(cell: UITableViewCell.self)
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
        
        let item = self.items[indexPath.row]
        cell.textLabel?.text = item
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
