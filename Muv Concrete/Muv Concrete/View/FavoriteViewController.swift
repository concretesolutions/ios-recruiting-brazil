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
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = FavoriteTableViewCell()
        guard let cell = Bundle.main.loadNibNamed(movieCell.identiifier, owner: self, options: nil)?.first as? FavoriteTableViewCell else { return UITableViewCell()}
        cell.movie = favoriteViewModel.getMovie(indexPath: indexPath)
        
        return cell

    }
    
    
}
