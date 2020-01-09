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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        /* TODO: Give indexPath to viewModel,
         * so it can figure what should give back
         */
        
        if indexPath.row == 0 {
            //cell.imageView?.image = UIImage(data: self.viewModel.bannerData)
        } else {
 
            let text = viewModel.getTopic(for: indexPath)
            cell.textLabel?.text = text
            
        }
        
        //cell.setup(with: cellViewModel)
        
        return cell
        
    }
    
}
