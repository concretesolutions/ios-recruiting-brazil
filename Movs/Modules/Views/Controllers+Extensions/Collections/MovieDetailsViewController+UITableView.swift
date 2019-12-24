//
//  MovieDetailsViewController+UITableView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 15/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate

extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

// MARK: - UITableViewDataSource

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfDetails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenresCell", for: indexPath) as? GenresDetailsTableViewCell else {
                fatalError("Failed to dequeue GenresCell as GenresDetailsTableViewCell")
            }
            
            cell.headingLabel.text = "Genres"
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.layoutIfNeeded()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? MovieDetailsTableViewCell else {
                fatalError("Failed to dequeue DetailCell as MovieDetailsTableViewCell")
            }
            
            let content = self.viewModel.detailsForItemAt(indexPath: indexPath)
            cell.headingLabel.text = content.0
            cell.contentLabel.text = content.1
            return cell
        }
    }
}
