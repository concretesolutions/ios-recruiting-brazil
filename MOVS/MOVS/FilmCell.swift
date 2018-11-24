//
//  FilmCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation

protocol FilmCell {
    func setup(withFilm film: ResponseFilm)
}
