//
//  CellSelected.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

protocol CellSelected: class {
    func goToDetalViewController(withFilm film: ResponseFilm)
}
