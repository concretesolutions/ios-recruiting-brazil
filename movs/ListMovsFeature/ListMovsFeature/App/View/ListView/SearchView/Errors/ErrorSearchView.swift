//
//  ErrorSearchView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 04/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import AssertModule

class ErrorSearchView: BaseSearchView {
    override func layoutSubviews() {
        super.layoutSubviews()
        baseImageView.image = Assets.Images.failureIcon?.withRenderingMode(.alwaysTemplate)
        baseImageView.tintColor = Colors.redDark
        
        setMessageNotFound("Um erro ocorreu. Por favor, tente novamente.")
    }
}
