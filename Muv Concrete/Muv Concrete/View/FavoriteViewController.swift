//
//  FavoriteViewController.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 21/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    let arrayMovie = [ "Thor", "avengers"]
    @IBOutlet weak var tableView: UITableView!
    
    let favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteViewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.activityStartAnimating()
        favoriteViewModel.readCoreData(completionHandler: { reload in
            self.configureUI()
        })
    }

    private func configureUI(){
        tableView.reloadData()
        view.activityStopAnimating()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = FavoriteTableViewCell()
        guard let cell = Bundle.main.loadNibNamed(movieCell.identiifier, owner: self, options: nil)?.first as? FavoriteTableViewCell else { return UITableViewCell()}
        
        cell.movie = favoriteViewModel.getMovie(indexPath: indexPath)
        
        return cell

    }
    
    
}
