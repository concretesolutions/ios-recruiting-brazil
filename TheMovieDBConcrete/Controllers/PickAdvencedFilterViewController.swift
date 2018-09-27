//
//  PickAdvencedFilterViewController.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 27/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class PickAdvencedFilterViewController: UIViewController,UITableViewDataSource,UITabBarDelegate {
    
    var uniqueYears = [String]()
    var isPickingGender = true
    var alreadyChosen = ""
    @IBOutlet weak var optionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        MovieDBAPIRequest.getAllRenres { (genres, error) in
            AllGenresSingleton.allGenres = genres
            self.optionsTableView.reloadData()
        }
        if !isPickingGender {
            let favoriteMovies = PersistenceService.retrieveFavoriteMovies()
            var movieYears = [String]()
            for movie in favoriteMovies.movies {
                movieYears.append(movie.year)
            }
            uniqueYears = Array(Set(movieYears))
            print(uniqueYears)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPickingGender {
            return AllGenresSingleton.allGenres.genresArray.count
        } else {
            return uniqueYears.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "option")
        if isPickingGender {
            cell.textLabel?.text = AllGenresSingleton.allGenres.genresArray[indexPath.row].name
            if cell.textLabel?.text == self.alreadyChosen {
                cell.accessoryType = .checkmark
            }
        } else {
            cell.textLabel?.text = uniqueYears[indexPath.row]
            if cell.textLabel?.text == self.alreadyChosen {
                cell.accessoryType = .checkmark
            }
        }
        return cell
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
