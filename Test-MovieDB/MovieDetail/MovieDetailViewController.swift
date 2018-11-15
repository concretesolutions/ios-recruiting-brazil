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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        middle = MovieDetailMiddle.init(delegate: self)
        
    }

}

extension MovieDetailViewController: UITableViewDelegate {
    
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
        case 1:
            cell.textLabel?.text = middle.movieToLoad.yearOfRelease
        case 2:
            cell.textLabel?.text = String(describing: middle.movieToLoad.genreID)
        case 3:
            cell.textLabel?.text = middle.movieToLoad.description
        default:
            break
        }
        return cell
    }
    
    
}


extension MovieDetailViewController: MovieDetailMiddleDelegate {
    
}
