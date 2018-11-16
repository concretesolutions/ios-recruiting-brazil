//
//  MovieDetailViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var posterImage: UIImageView!
    var middle: MovieDetailMiddle!
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 22)
        button.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        button.setImage(UIImage(named: "favorite_full_icon"), for: .selected)
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        if middle.movieToLoad.isFavorite == true {
            favoriteButton.isSelected = true
        }
        detailTableView.dataSource = self
        detailTableView.delegate = self
        posterImage.loadImageFromURLString(urlStirng: middle.movieToLoad.posterPath)
        detailTableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @objc func buttonSelected() {
        if favoriteButton.isSelected == true {
            favoriteButton.isSelected = false
            //middle.removeFavorite(movie: middle.movieToLoad)
            middle.removeFavorite(movie: middle.favoriteMoviesMiddle.favoritesFetched[middle.indexOfMovie])
            
        } else if favoriteButton.isSelected == false {
            favoriteButton.isSelected = true
            middle.savedMovie(movie: middle.movieToLoad)
        }
    }
    
    func convertDateFormat(input: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: input)
        dateFormatter.dateFormat = "yyyy"
        guard let returnDate = date else { return "" }
        return dateFormatter.string(from: returnDate)
    }
}

extension MovieDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if indexPath.row == 0 {
            cell?.accessoryView = favoriteButton
        }
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = middle.movieToLoad.title
            cell.accessoryView? = favoriteButton
            cell.contentView.addSubview(favoriteButton)
            favoriteButton.translatesAutoresizingMaskIntoConstraints = false
            favoriteButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            favoriteButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10).isActive = true
            
        case 1:
            cell.textLabel?.text = convertDateFormat(input: middle.movieToLoad.yearOfRelease)
        case 2:
            cell.textLabel?.text = String(describing: middle.movieToLoad.genreID)
        case 3:
            cell.textLabel?.text = middle.movieToLoad.description
            cell.textLabel?.numberOfLines = 0
        default:
            break
        }
        return cell
    }
}

extension MovieDetailViewController: MovieDetailMiddleDelegate {
    
    func didSaveMovie() {
        middle.fetchMovies()
        print("fetchou saving")
    }
    
    func didRemoveMovie() {
        middle.fetchMovies()
        print("fetchou removing")
    }
}
