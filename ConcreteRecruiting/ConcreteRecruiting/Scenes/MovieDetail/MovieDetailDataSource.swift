//
//  MovieDetailDataDource.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 07/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieDetailDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: MovieDetailViewModel
    
    init(with viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DetailTableViewCell else {
            fatalError("Unable to dequeue cell with the Cell Identifier")
        }
    
        let section = viewModel.getSection(for: indexPath)
        cell.setup(with: section, viewModel: viewModel)
        
        return cell
        
    }
    
}
