//
//  MovieViewController.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 21/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var movie = Movie()

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movie"
        self.backgroundImage.image = movie.backgroundImage
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.moviesTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 44
        case 3:
            return tableView.rowHeight
        default:
            return 44
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = moviesTableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath as IndexPath) as! NameTableViewCell
            cell.movieName.text = movie.name
            cell.movie = self.movie
            let isFavorite = PersistenceService.isFavorite(withTitle: movie.name)
            if isFavorite {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
                cell.isFavorite = true
            } else {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
                cell.isFavorite = false
            }
            
            return cell
        } else if indexPath.row == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = movie.year
            return cell
        } else if indexPath.row == 2 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            var genreStr = ""
            var first = true
            for genre in movie.genres.genresArray {
                if first {
                    genreStr += AllGenresSingleton.allGenres.getGenreName(withId: genre.genreId)
                    first = false
                } else {
                    genreStr += "," + AllGenresSingleton.allGenres.getGenreName(withId: genre.genreId)
                }
            }
            cell.textLabel?.text = genreStr
            return cell
        } else {
            let cell = moviesTableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath as IndexPath) as! DescriptionTableViewCell
            cell.descriptionLabel.text = movie.movieDescription
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, .greatestFiniteMagnitude)
            return cell
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
