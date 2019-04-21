//
//  FilterViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import UIKit

class FilterTypesTableViewController: UITableViewController {

    var genreNames: [String] = []
    var years: [String] = []
    var goingForward = false
    
    override func viewWillDisappear(_ animated: Bool) {
        guard !goingForward else {
            goingForward = false
            return
        }
        guard let favoritesVC = navigationController?.children.first as? FavoritesViewController else { return }
        favoritesVC.presenter.combineFilters(genres: genreNames, years: years)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        goingForward = true
        guard let genresVC = segue.destination as? GenresViewController else {
            guard let yearsVC = segue.destination as? YearsViewController else { return }
            yearsVC.selected = years
            return
        }
        genresVC.selected = genreNames
    }

}
