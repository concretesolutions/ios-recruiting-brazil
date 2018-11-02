//
//  MovieDetailsViewController+UITableViewDataSource.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableView.titleCellReuseIdentifier) as? DetailsTitleTableViewCell else { break }
            cell.toggleFavoriteAction = self.toggleFavorite
            cell.set(viewModel: self.viewModel)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableView.defaultLabelCellReuseIdentifier) as? DetailsDefaultLabelTableViewCell else { break }
            cell.label.text = self.viewModel.year
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableView.defaultLabelCellReuseIdentifier) as? DetailsDefaultLabelTableViewCell else { break }
            cell.label.text = self.viewModel.genres.joined(separator: ", ")
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableView.overviewCellReuseIdentifier) as? DetailsOverviewTableViewCell else { break }
            cell.set(text: self.viewModel.overview)
            
            return cell
        default:
            return UITableViewCell(frame: .zero)
        }
        
        return UITableViewCell(frame: .zero)
    }
}
