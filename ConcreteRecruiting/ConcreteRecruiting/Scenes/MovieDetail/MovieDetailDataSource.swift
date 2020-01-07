//
//  MovieDetailDataDource.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 07/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieDetailDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: MovieCellViewModel
    
    init(with viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Have this number come from the viewModel
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        /* TODO: Give indexPath to viewModel,
         * so it can figure what should give back
         */
 
        //let cellViewModel = viewModel.getViewModel(for: indexPath)
        
        //cell.setup(with: cellViewModel)
        
        return cell
        
    }
    
}
