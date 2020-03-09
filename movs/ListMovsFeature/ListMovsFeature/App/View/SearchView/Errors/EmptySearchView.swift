//
//  SearchView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 03/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import AssertModule

class EmptySearchView: BaseSearchView {
    
    let messageDefault = "A busca por '%@' não resultou em nenhum resultado."
    var message: String = "" {
        didSet {
            let message = String(format: messageDefault, self.message)
            setMessageNotFound(message)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseImageView.image = Assets.Images.searchIcon?.withRenderingMode(.alwaysTemplate)
        
    }
}


