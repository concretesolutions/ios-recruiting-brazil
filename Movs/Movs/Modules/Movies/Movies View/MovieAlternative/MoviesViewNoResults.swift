//
//  MoviesViewNoResults.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 13/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesViewNoResults: UIView {
    
    var movieView: MoviesView?
    @IBOutlet weak var outletResult: UILabel!
    
    func setup(movieView: MoviesView) {
        self.movieView = movieView
    }
    
    func noResult(searchText: String) {
        let message = "Sua busca por '<<x>>' não resultou em nenhum resultado."
        self.outletResult.text = message.replacingOccurrences(of: "'<<x>>'", with: "'\(searchText)'")
    }
    
}
