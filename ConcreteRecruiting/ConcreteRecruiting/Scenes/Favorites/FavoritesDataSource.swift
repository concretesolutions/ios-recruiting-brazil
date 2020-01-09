//
//  FavoritesDataSource.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 09/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class FavoritesDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FavoriteTableViewCell else {
            fatalError("Unable to dequeue a cell with the Cell Identifier")
        }
        
        cell.posterImageView.image = UIImage(named: "Filter")
        cell.titleLabel.text = "Thor"
        cell.yearLabel.text = "2008"
        cell.descriptionLabel.text = "Arroz Arroz Arroz"
        
        return cell
        
    }
    
}
